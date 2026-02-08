int** flipAndInvertImage(int** image, int imageSize, int* imageColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = imageSize;
    *returnColumnSizes = imageColSize;

    for (int i = 0; i < imageSize; i++) {
        int left = 0;
        int right = imageColSize[i] - 1;

        while (left <= right) {
            int temp = image[i][left];
            image[i][left] = 1 - image[i][right];
            image[i][right] = 1 - temp;

            left++;
            right--;
        }
    }
    return image;
}