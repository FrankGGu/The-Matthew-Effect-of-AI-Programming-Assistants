#include <stdio.h>
#include <stdlib.h>

int findPeakII(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];

    int left = 0, right = cols - 1;

    while (left <= right) {
        int midCol = left + (right - left) / 2;
        int maxRow = 0;

        for (int i = 1; i < rows; i++) {
            if (matrix[i][midCol] > matrix[maxRow][midCol]) {
                maxRow = i;
            }
        }

        if (midCol > 0 && matrix[maxRow][midCol] < matrix[maxRow][midCol - 1]) {
            right = midCol - 1;
        } else if (midCol < cols - 1 && matrix[maxRow][midCol] < matrix[maxRow][midCol + 1]) {
            left = midCol + 1;
        } else {
            return maxRow * cols + midCol;
        }
    }

    return -1;
}