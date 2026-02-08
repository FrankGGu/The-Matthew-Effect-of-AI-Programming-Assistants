#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** modifyTheMatrix(int** matrix, int matrixSize, int* matrixColSize){
    int max_vals[*matrixColSize];
    for (int j = 0; j < *matrixColSize; j++) {
        max_vals[j] = 0;
        for (int i = 0; i < matrixSize; i++) {
            if (matrix[i][j] > max_vals[j]) {
                max_vals[j] = matrix[i][j];
            }
        }
    }
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < *matrixColSize; j++) {
            if (matrix[i][j] == 0) {
                matrix[i][j] = max_vals[j];
            }
        }
    }
    return matrix;
}