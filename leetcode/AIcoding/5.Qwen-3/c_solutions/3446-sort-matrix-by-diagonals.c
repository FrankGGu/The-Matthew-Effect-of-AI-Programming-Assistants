#include <stdio.h>
#include <stdlib.h>

int** diagonalSort(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int** result = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
    }

    int maxDiag = m + n - 1;
    int* diag = (int*)malloc(maxDiag * sizeof(int));

    for (int d = 0; d < maxDiag; d++) {
        int i = d < n ? 0 : d - n + 1;
        int j = d < n ? d : n - 1;
        int k = 0;
        while (i < m && j >= 0) {
            diag[k++] = matrix[i++][j--];
        }
        qsort(diag, k, sizeof(int), (int (*)(const void*, const void*))strcmp);
        i = d < n ? 0 : d - n + 1;
        j = d < n ? d : n - 1;
        k = 0;
        while (i < m && j >= 0) {
            result[i++][j--] = diag[k++];
        }
    }

    free(diag);
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    return result;
}