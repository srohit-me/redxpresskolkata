rm -rf ../*.webp ../jpg
mkdir ../jpg

cd gallery
for img in *; do
	cwebp -quiet -resize 1920 0 -size $((128*1024)) -o  ../../${img%.*}.webp  $img
	cwebp -quiet -resize 720 0  -size $((64*1024))  -o  ../../s${img%.*}.webp $img
	convert $img -resize 1920x -strip -define jpeg:extent=$((128*1024))B ../../jpg/${img%.*}.jpg
	convert $img -resize 720x  -strip -define jpeg:extent=$((64*1024))B  ../../jpg/s${img%.*}.jpg
done
cd ..

cd offers
for img in *; do
	cwebp -quiet -resize 320 0 -size $((32*1024)) -o ../../${img%.*}.webp $img
	convert $img -resize 320x  -strip -define jpeg:extent=$((32*1024))B ../../jpg/${img%.*}.jpg
done
cd ..

cd menu
for pdf in *.pdf; do
	convert "${pdf}" -strip -density 150 ../../"${pdf%.*}.webp"
	convert "${pdf}" -strip -density 150 ../../jpg/"${pdf%.*}.jpg"
done
for img in *.jpg; do
	cwebp -quiet -o  ../../${img%.*}.webp $img
	convert "${img}" -strip ../../jpg/${img%.*}.jpg
done
cd ..