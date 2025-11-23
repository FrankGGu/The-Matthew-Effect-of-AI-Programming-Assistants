#include <stdio.h>
#include <stdlib.h>

int** flipAndInvertImage(int** image, int imageSize, int* imageColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(imageSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(imageSize * sizeof(int));
    for (int i = 0; i < imageSize; i++) {
        result[i] = (int*)malloc(*imageColSize * sizeof(int));
        (*returnColumnSizes)[i] = *imageColSize;
        for (int j = 0; j < *imageColSize; j++) {
            result[i][j] = 1 - image[i][*imageColSize - 1 - j];
        }
    }
    *returnSize = imageSize;
    return result;
}