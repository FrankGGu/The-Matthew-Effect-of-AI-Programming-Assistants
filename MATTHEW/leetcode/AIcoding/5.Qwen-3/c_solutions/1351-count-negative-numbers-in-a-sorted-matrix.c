#include <stdio.h>
#include <stdlib.h>

int countNegatives(int** matrix, int matrixSize, int* matrixColSize) {
    int count = 0;
    int rows = matrixSize;
    int cols = matrixColSize[0];

    int i = 0;
    int j = cols - 1;

    while (i < rows && j >= 0) {
        if (matrix[i][j] < 0) {
            count += rows - i;
            j--;
        } else {
            i++;
        }
    }

    return count;
}