int minAbsDiffInSubmatrix(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int minDiff = INT_MAX;
    for (int i = 0; i <= matrixSize - k; i++) {
        for (int j = 0; j <= matrixColSize[0] - k; j++) {
            int *subMatrix = (int*)malloc(k * k * sizeof(int));
            int index = 0;
            for (int x = 0; x < k; x++) {
                for (int y = 0; y < k; y++) {
                    subMatrix[index++] = matrix[i + x][j + y];
                }
            }
            qsort(subMatrix, k * k, sizeof(int), cmp);
            for (int m = 1; m < k * k; m++) {
                int diff = subMatrix[m] - subMatrix[m - 1];
                if (diff < minDiff) {
                    minDiff = diff;
                }
            }
            free(subMatrix);
        }
    }
    return minDiff;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}