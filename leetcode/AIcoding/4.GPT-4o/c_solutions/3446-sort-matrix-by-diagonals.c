#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

void diagonalSort(int** mat, int matSize, int* matColSize) {
    int row, col;
    int n = matSize, m = *matColSize;

    for (int i = 0; i < n; i++) {
        int j = i, k = 0;
        int diag[100] = {0}, count = 0;

        while (j < n && k < m) {
            diag[count++] = mat[j][k];
            j++;
            k++;
        }

        qsort(diag, count, sizeof(int), cmp);

        j = i, k = 0;
        for (int l = 0; l < count; l++) {
            mat[j][k] = diag[l];
            j++;
            k++;
        }
    }

    for (int i = 1; i < m; i++) {
        int j = 0, k = i;
        int diag[100] = {0}, count = 0;

        while (j < n && k < m) {
            diag[count++] = mat[j][k];
            j++;
            k++;
        }

        qsort(diag, count, sizeof(int), cmp);

        j = 0, k = i;
        for (int l = 0; l < count; l++) {
            mat[j][k] = diag[l];
            j++;
            k++;
        }
    }
}