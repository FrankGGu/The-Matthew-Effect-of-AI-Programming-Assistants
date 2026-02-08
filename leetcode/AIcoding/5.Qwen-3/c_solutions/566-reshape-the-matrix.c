#include <stdio.h>
#include <stdlib.h>

int** matrixReshape(int** mat, int matSize, int* matColSize, int r, int c, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];
    if (m * n != r * c) {
        *returnSize = 0;
        return NULL;
    }

    int** result = (int**)malloc(r * sizeof(int*));
    *returnColumnSizes = (int*)malloc(r * sizeof(int));
    for (int i = 0; i < r; i++) {
        result[i] = (int*)malloc(c * sizeof(int));
        (*returnColumnSizes)[i] = c;
    }

    for (int i = 0; i < r * c; i++) {
        result[i / c][i % c] = mat[i / n][i % n];
    }

    *returnSize = r;
    return result;
}