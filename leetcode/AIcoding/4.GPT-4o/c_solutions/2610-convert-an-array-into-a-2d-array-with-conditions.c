int** construct2DArray(int* original, int originalSize, int* returnSize, int** returnColumnSizes) {
    if (originalSize % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    int n = originalSize / 2;
    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = original[i * 2];
        result[i][1] = original[i * 2 + 1];
        (*returnColumnSizes)[i] = 2;
    }

    *returnSize = n;
    return result;
}