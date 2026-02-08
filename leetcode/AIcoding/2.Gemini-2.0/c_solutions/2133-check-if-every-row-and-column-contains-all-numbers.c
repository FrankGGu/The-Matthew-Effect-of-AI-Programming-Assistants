#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkValid(int** matrix, int matrixSize, int* matrixColSize){
    for (int i = 0; i < matrixSize; i++) {
        bool row_seen[matrixSize + 1];
        bool col_seen[matrixSize + 1];
        for (int j = 0; j <= matrixSize; j++){
            row_seen[j] = false;
            col_seen[j] = false;
        }

        for (int j = 0; j < matrixSize; j++) {
            if (matrix[i][j] >= 1 && matrix[i][j] <= matrixSize) {
                row_seen[matrix[i][j]] = true;
            }
            if (matrix[j][i] >= 1 && matrix[j][i] <= matrixSize) {
                col_seen[matrix[j][i]] = true;
            }
        }

        for (int k = 1; k <= matrixSize; k++) {
            if (!row_seen[k] || !col_seen[k]) {
                return false;
            }
        }
    }
    return true;
}