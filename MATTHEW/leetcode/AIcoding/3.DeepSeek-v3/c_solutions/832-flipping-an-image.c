/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are stored in *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** flipAndInvertImage(int** image, int imageSize, int* imageColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = imageSize;
    *returnColumnSizes = malloc(imageSize * sizeof(int));
    for (int i = 0; i < imageSize; i++) {
        (*returnColumnSizes)[i] = imageColSize[i];
    }

    int** result = malloc(imageSize * sizeof(int*));
    for (int i = 0; i < imageSize; i++) {
        result[i] = malloc(imageColSize[i] * sizeof(int));
        for (int j = 0; j < imageColSize[i]; j++) {
            result[i][j] = 1 - image[i][imageColSize[i] - 1 - j];
        }
    }

    return result;
}