#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** diagonalSort(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes){
    int m = matSize;
    int n = matColSize[0];
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(sizeof(int) * m);
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    for (int k = 0; k < m; k++) {
        int len = 0;
        for (int i = k, j = 0; i < m && j < n; i++, j++) {
            len++;
        }
        int* diag = (int*)malloc(sizeof(int) * len);
        int idx = 0;
        for (int i = k, j = 0; i < m && j < n; i++, j++) {
            diag[idx++] = mat[i][j];
        }
        qsort(diag, len, sizeof(int), (int (*)(const void *, const void *))compare);
        idx = 0;
        for (int i = k, j = 0; i < m && j < n; i++, j++) {
            mat[i][j] = diag[idx++];
        }
        free(diag);
    }

    for (int k = 1; k < n; k++) {
        int len = 0;
        for (int i = 0, j = k; i < m && j < n; i++, j++) {
            len++;
        }
        int* diag = (int*)malloc(sizeof(int) * len);
        int idx = 0;
        for (int i = 0, j = k; i < m && j < n; i++, j++) {
            diag[idx++] = mat[i][j];
        }
        qsort(diag, len, sizeof(int), (int (*)(const void *, const void *))compare);
        idx = 0;
        for (int i = 0, j = k; i < m && j < n; i++, j++) {
            mat[i][j] = diag[idx++];
        }
        free(diag);
    }

    return mat;
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}