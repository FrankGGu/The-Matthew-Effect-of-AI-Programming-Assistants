#include <stdio.h>
#include <stdlib.h>

int** rotateMatrix(int** matrix, int matrixSize, int* matrixColSize) {
    int** rotated = (int**)malloc(matrixSize * sizeof(int*));
    for (int i = 0; i < matrixSize; i++) {
        rotated[i] = (int*)malloc(matrixSize * sizeof(int));
    }
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixSize; j++) {
            rotated[j][matrixSize - 1 - i] = matrix[i][j];
        }
    }
    return rotated;
}

int compareMatrix(int** matrix1, int** matrix2, int matrixSize, int* matrixColSize) {
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixSize; j++) {
            if (matrix1[i][j] != matrix2[i][j]) {
                return 0;
            }
        }
    }
    return 1;
}

bool findRotation(int** matrix, int matrixSize, int* matrixColSize, int** target) {
    int** rotated = matrix;
    for (int i = 0; i < 4; i++) {
        if (compareMatrix(rotated, target, matrixSize, matrixColSize)) {
            return true;
        }
        rotated = rotateMatrix(rotated, matrixSize, matrixColSize);
    }
    return false;
}