#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool findRotation(int** matrix, int matrixSize, int* matrixColSize, int** target, int targetSize, int* targetColSize) {
    for (int k = 0; k < 4; k++) {
        bool match = true;
        for (int i = 0; i < matrixSize; i++) {
            for (int j = 0; j < matrixSize; j++) {
                if (matrix[i][j] != target[i][j]) {
                    match = false;
                    break;
                }
            }
            if (!match) break;
        }
        if (match) return true;

        int** rotated = (int**)malloc(sizeof(int*) * matrixSize);
        for (int i = 0; i < matrixSize; i++) {
            rotated[i] = (int*)malloc(sizeof(int) * matrixSize);
        }

        for (int i = 0; i < matrixSize; i++) {
            for (int j = 0; j < matrixSize; j++) {
                rotated[j][matrixSize - 1 - i] = matrix[i][j];
            }
        }

        for (int i = 0; i < matrixSize; i++) {
            for (int j = 0; j < matrixSize; j++) {
                matrix[i][j] = rotated[i][j];
            }
            free(rotated[i]);
        }
        free(rotated);
    }

    return false;
}