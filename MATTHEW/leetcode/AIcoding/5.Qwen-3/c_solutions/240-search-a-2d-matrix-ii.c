#include <stdio.h>
#include <stdlib.h>

bool searchMatrix(int** matrix, int matrixRowSize, int matrixColSize) {
    int row = 0;
    int col = matrixColSize - 1;

    while (row < matrixRowSize && col >= 0) {
        int val = matrix[row][col];
        if (val == 0) {
            return true;
        } else if (val > 0) {
            col--;
        } else {
            row++;
        }
    }

    return false;
}