var flipAndInvertImage = function(image) {
    for (let i = 0; i < image.length; i++) {
        image[i].reverse();
        for (let j = 0; j < image[i].length; j++) {
            image[i][j] = 1 - image[i][j];
        }
    }
    return image;
};