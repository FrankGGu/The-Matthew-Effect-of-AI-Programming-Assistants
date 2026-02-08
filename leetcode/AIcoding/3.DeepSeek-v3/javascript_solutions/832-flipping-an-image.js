var flipAndInvertImage = function(image) {
    return image.map(row => row.reverse().map(num => num ^ 1));
};