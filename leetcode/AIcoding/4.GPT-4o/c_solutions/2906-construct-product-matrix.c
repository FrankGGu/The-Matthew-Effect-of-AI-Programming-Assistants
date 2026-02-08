int** constructMatrix(int* a, int aSize, int* b, int bSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = aSize;
    *returnColumnSizes = (int*)malloc(aSize * sizeof(int));
    for (int i = 0; i < aSize; i++) {
        (*returnColumnSizes)[i] = bSize;
    }

    int** result = (int**)malloc(aSize * sizeof(int*));
    for (int i = 0; i < aSize; i++) {
        result[i] = (int*)malloc(bSize * sizeof(int));
        for (int j = 0; j < bSize; j++) {
            result[i][j] = a[i] * b[j];
        }
    }

    return result;
}