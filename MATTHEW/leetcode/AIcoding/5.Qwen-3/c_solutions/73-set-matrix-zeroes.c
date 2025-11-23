#include <stdio.h>
#include <stdlib.h>

void setZeroes(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int firstRow = 0;
    int firstCol = 0;

    for (int i = 0; i < rows; i++) {
        if (matrix[i][0] == 0) {
            firstCol = 1;
        }
    }

    for (int j = 0; j < cols; j++) {
        if (matrix[0][j] == 0) {
            firstRow = 1;
        }
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 1; j < cols; j++) {
            if (matrix[i][j] == 0) {
                matrix[i][0] = 0;
                matrix[0][j] = 0;
            }
        }
    }

    for (int i = 1; i < rows; i++) {
        if (matrix[i][0] == 0) {
            for (int j = 1; j < cols; j++) {
                matrix[i][j] = 0;
            }
        }
    }

    for (int j = 1; j < cols; j++) {
        if (matrix[0][j] == 0) {
            for (int i = 1; i < rows; i++) {
                matrix[i][j] = 0;
            }
        }
    }

    if (firstRow) {
        for (int j = 0; j < cols; j++) {
            matrix[0][j] = 0;
        }
    }

    if (firstCol) {
        for (int i = 0; i < rows; i++) {
            matrix[i][0] = 0;
        }
    }
}