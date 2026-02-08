#include <stdlib.h> // Required for malloc

int** modifyMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int m = matrixSize;
    int n = matrixColSize[0];

    for (int j = 0; j < n; j++) {
        int currentColMax = 0;

        for (int i = 0; i < m; i++) {
            if (matrix[i][j] != -1) {
                if (matrix[i][j] > currentColMax) {
                    currentColMax = matrix[i][j];
                }
            }
        }

        for (int i = 0; i < m; i++) {
            if (matrix[i][j] == -1) {
                matrix[i][j] = currentColMax;
            }
        }
    }

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    return matrix;
}