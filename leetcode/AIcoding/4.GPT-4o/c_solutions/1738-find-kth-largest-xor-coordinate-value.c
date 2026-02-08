int kthLargestValue(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int m = matrixSize, n = *matrixColSize;
    int* xorValues = (int*)malloc(m * n * sizeof(int));
    int index = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (i > 0) matrix[i][j] ^= matrix[i-1][j];
            if (j > 0) matrix[i][j] ^= matrix[i][j-1];
            if (i > 0 && j > 0) matrix[i][j] ^= matrix[i-1][j-1];
            xorValues[index++] = matrix[i][j];
        }
    }

    qsort(xorValues, index, sizeof(int), cmp);
    int result = xorValues[index - k];
    free(xorValues);
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}