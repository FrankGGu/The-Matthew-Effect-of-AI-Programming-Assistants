#include <stdio.h>
#include <stdlib.h>

int maxSum(int** matrix, int matrixSize, int* matrixColSize) {
    int maxSum = -100000;
    for (int i = 1; i < matrixSize - 1; i++) {
        for (int j = 1; j < (*matrixColSize) - 1; j++) {
            int currentSum = matrix[i-1][j-1] + matrix[i-1][j] + matrix[i-1][j+1] +
                             matrix[i][j] +
                             matrix[i+1][j-1] + matrix[i+1][j] + matrix[i+1][j+1];
            if (currentSum > maxSum) {
                maxSum = currentSum;
            }
        }
    }
    return maxSum;
}