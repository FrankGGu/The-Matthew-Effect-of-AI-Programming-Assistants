#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void setZeroes(int** matrix, int matrixSize, int* matrixColSize){
    bool firstRowZero = false;
    bool firstColZero = false;

    for (int i = 0; i < matrixColSize[0]; i++) {
        if (matrix[0][i] == 0) {
            firstRowZero = true;
            break;
        }
    }

    for (int i = 0; i < matrixSize; i++) {
        if (matrix[i][0] == 0) {
            firstColZero = true;
            break;
        }
    }

    for (int i = 1; i < matrixSize; i++) {
        for (int j = 1; j < matrixColSize[0]; j++) {
            if (matrix[i][j] == 0) {
                matrix[i][0] = 0;
                matrix[0][j] = 0;
            }
        }
    }

    for (int i = 1; i < matrixSize; i++) {
        for (int j = 1; j < matrixColSize[0]; j++) {
            if (matrix[i][0] == 0 || matrix[0][j] == 0) {
                matrix[i][j] = 0;
            }
        }
    }

    if (firstRowZero) {
        for (int i = 0; i < matrixColSize[0]; i++) {
            matrix[0][i] = 0;
        }
    }

    if (firstColZero) {
        for (int i = 0; i < matrixSize; i++) {
            matrix[i][0] = 0;
        }
    }
}