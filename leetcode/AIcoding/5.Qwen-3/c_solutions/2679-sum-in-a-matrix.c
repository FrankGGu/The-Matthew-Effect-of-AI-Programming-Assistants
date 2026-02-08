#include <stdio.h>
#include <stdlib.h>

int matrixSum(int** matrix, int matrixSize, int* matrixColSize) {
    int maxSum = 0;
    for (int j = 0; j < *matrixColSize; j++) {
        int maxVal = 0;
        for (int i = 0; i < matrixSize; i++) {
            if (matrix[i][j] > maxVal) {
                maxVal = matrix[i][j];
            }
        }
        maxSum += maxVal;
    }
    return maxSum;
}