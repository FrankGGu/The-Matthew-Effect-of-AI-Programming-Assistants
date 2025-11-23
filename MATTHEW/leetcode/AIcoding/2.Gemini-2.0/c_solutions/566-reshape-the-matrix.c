#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** matrixReshape(int** mat, int matSize, int* matColSize, int r, int c, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];

    if (m * n != r * c) {
        *returnSize = m;
        *returnColumnSizes = matColSize;
        return mat;
    }

    int** reshaped = (int**)malloc(r * sizeof(int*));
    *returnColumnSizes = (int*)malloc(r * sizeof(int));

    for (int i = 0; i < r; i++) {
        reshaped[i] = (int*)malloc(c * sizeof(int));
        (*returnColumnSizes)[i] = c;
    }

    *returnSize = r;

    int row = 0;
    int col = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            reshaped[row][col] = mat[i][j];
            col++;
            if (col == c) {
                col = 0;
                row++;
            }
        }
    }

    return reshaped;
}