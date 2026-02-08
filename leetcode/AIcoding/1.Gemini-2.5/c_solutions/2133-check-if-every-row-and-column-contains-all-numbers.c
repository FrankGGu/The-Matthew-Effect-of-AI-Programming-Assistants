#include <stdbool.h>
#include <stdlib.h>

bool checkValid(int** matrix, int matrixSize, int* matrixColSize) {
    for (int i = 0; i < matrixSize; i++) {
        bool* rowCheck = (bool*)calloc(matrixSize + 1, sizeof(bool));
        bool* colCheck = (bool*)calloc(matrixSize + 1, sizeof(bool));

        for (int j = 0; j < matrixSize; j++) {
            if (rowCheck[matrix[i][j]]) {
                free(rowCheck);
                free(colCheck);
                return false;
            }
            rowCheck[matrix[i][j]] = true;

            if (colCheck[matrix[j][i]]) {
                free(rowCheck);
                free(colCheck);
                return false;
            }
            colCheck[matrix[j][i]] = true;
        }

        for (int k = 1; k <= matrixSize; k++) {
            if (!rowCheck[k] || !colCheck[k]) {
                free(rowCheck);
                free(colCheck);
                return false;
            }
        }
        free(rowCheck);
        free(colCheck);
    }
    return true;
}