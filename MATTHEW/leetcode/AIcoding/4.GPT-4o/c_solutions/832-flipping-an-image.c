int** flipAndInvertImage(int** image, int imageSize, int* imageColSize) {
    for (int i = 0; i < imageSize; i++) {
        for (int j = 0; j < imageColSize[i] / 2; j++) {
            int temp = image[i][j];
            image[i][j] = image[i][imageColSize[i] - 1 - j] ^ 1;
            image[i][imageColSize[i] - 1 - j] = temp ^ 1;
        }
        if (imageColSize[i] % 2 == 1) {
            image[i][imageColSize[i] / 2] ^= 1;
        }
    }
    return image;
}