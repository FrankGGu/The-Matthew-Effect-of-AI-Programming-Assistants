#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* extract咒文(char** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    char* result = (char*)malloc((rows * cols + 1) * sizeof(char));
    int index = 0;

    for (int col = 0; col < cols; col++) {
        for (int row = 0; row < rows; row++) {
            result[index++] = matrix[row][col];
        }
    }

    result[index] = '\0';
    return result;
}