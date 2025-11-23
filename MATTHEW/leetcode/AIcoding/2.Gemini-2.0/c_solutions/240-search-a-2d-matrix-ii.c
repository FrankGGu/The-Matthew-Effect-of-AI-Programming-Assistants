#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool searchMatrix(int** matrix, int matrixSize, int* matrixColSize, int target) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        return false;
    }

    int row = 0;
    int col = *matrixColSize - 1;

    while (row < matrixSize && col >= 0) {
        if (matrix[row][col] == target) {
            return true;
        } else if (matrix[row][col] < target) {
            row++;
        } else {
            col--;
        }
    }

    return false;
}