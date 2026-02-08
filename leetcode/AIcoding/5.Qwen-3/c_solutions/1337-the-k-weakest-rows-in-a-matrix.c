#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *rowA = (int *)a;
    int *rowB = (int *)b;
    if (rowA[1] != rowB[1]) {
        return rowA[1] - rowB[1];
    }
    return rowA[0] - rowB[0];
}

int* kWeakestRows(int** mat, int matSize, int* matColSize, int k, int* returnSize) {
    int *result = (int *)malloc(k * sizeof(int));
    int *rows = (int *)malloc(matSize * 2 * sizeof(int));

    for (int i = 0; i < matSize; i++) {
        int count = 0;
        for (int j = 0; j < *matColSize; j++) {
            if (mat[i][j] == 1) {
                count++;
            } else {
                break;
            }
        }
        rows[2 * i] = i;
        rows[2 * i + 1] = count;
    }

    qsort(rows, matSize, 2 * sizeof(int), compare);

    for (int i = 0; i < k; i++) {
        result[i] = rows[2 * i];
    }

    *returnSize = k;
    return result;
}