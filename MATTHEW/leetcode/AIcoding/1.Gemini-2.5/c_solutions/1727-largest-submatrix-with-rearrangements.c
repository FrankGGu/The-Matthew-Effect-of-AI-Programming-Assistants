#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int largestSubmatrix(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        return 0;
    }

    int m = matrixSize;
    int n = *matrixColSize;
    int maxArea = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 1 && i > 0) {
                matrix[i][j] += matrix[i-1][j];
            }
        }

        qsort(matrix[i], n, sizeof(int), compareIntegers);

        for (int k = 0; k < n; k++) {
            int currentArea = matrix[i][k] * (n - k);
            if (currentArea > maxArea) {
                maxArea = currentArea;
            }
        }
    }

    return maxArea;
}