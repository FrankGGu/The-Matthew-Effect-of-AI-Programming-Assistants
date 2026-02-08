#include <stdlib.h>

int** matrixReshape(int** mat, int matSize, int* matColSize, int r, int c, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = *matColSize;

    if (m * n != r * c) {
        *returnSize = m;
        *returnColumnSizes = (int*)malloc(m * sizeof(int));
        for (int i = 0; i < m; i++) {
            (*returnColumnSizes)[i] = n;
        }
        return mat;
    }

    int** reshapedMat = (int**)malloc(r * sizeof(int*));
    for (int i = 0; i < r; i++) {
        reshapedMat[i] = (int*)malloc(c * sizeof(int));
    }

    int current_row = 0;
    int current_col = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            reshapedMat[current_row][current_col] = mat[i][j];
            current_col++;
            if (current_col == c) {
                current_col = 0;
                current_row++;
            }
        }
    }

    *returnSize = r;
    *returnColumnSizes = (int*)malloc(r * sizeof(int));
    for (int i = 0; i < r; i++) {
        (*returnColumnSizes)[i] = c;
    }

    return reshapedMat;
}