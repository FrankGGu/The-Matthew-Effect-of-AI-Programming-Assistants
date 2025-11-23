#include <stdio.h>
#include <stdlib.h>

bool checkValid(int** matrix, int matrixSize, int* matrixColSize) {
    int n = matrixSize;
    int* rows = (int*)calloc(n, sizeof(int));
    int* cols = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int num = matrix[i][j];
            if (num < 1 || num > n) return false;
            if ((rows[i] & (1 << (num - 1))) != 0) return false;
            if ((cols[j] & (1 << (num - 1))) != 0) return false;
            rows[i] |= (1 << (num - 1));
            cols[j] |= (1 << (num - 1));
        }
    }

    free(rows);
    free(cols);
    return true;
}