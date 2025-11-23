#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** transpose(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int R = matrixSize;
    int C = *matrixColSize;

    *returnSize = C;
    *returnColumnSizes = (int*)malloc(sizeof(int) * C);
    for (int i = 0; i < C; i++) {
        (*returnColumnSizes)[i] = R;
    }

    int** transposed = (int**)malloc(sizeof(int*) * C);
    for (int i = 0; i < C; i++) {
        transposed[i] = (int*)malloc(sizeof(int) * R);
    }

    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            transposed[j][i] = matrix[i][j];
        }
    }

    return transposed;
}