int** construct2DArray(int* original, int originalSize, int originalColSize, int* returnSize, int** returnColumnSizes) {
    if (originalSize % originalColSize != 0) {
        *returnSize = 0;
        return NULL;
    }
    int rows = originalSize / originalColSize;
    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = originalColSize;
    }
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(originalColSize * sizeof(int));
        for (int j = 0; j < originalColSize; j++) {
            result[i][j] = original[i * originalColSize + j];
        }
    }
    return result;
}