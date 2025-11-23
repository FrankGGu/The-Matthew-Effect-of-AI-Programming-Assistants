#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSumSubmatrix(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int maxSum = INT_MIN;

    for (int left = 0; left < cols; left++) {
        int rowSum[rows];
        for (int i = 0; i < rows; i++) {
            rowSum[i] = 0;
        }

        for (int right = left; right < cols; right++) {
            for (int i = 0; i < rows; i++) {
                rowSum[i] += matrix[i][right];
            }

            for (int i = 0; i < rows; i++) {
                int currentSum = 0;
                for (int j = i; j < rows; j++) {
                    currentSum += rowSum[j];
                    if (currentSum <= k && currentSum > maxSum) {
                        maxSum = currentSum;
                    }
                }
            }

            if (maxSum == k) return k;
        }
    }

    if (maxSum == INT_MIN) {
        maxSum = INT_MIN;
        for(int i = 0; i < rows; i++) {
            for(int j = 0; j < cols; j++) {
                if(matrix[i][j] <= k && matrix[i][j] > maxSum) {
                    maxSum = matrix[i][j];
                }
            }
        }
    }

    if(maxSum == INT_MIN) {
        maxSum = -1000000;
        for (int left = 0; left < cols; left++) {
            int rowSum[rows];
            for (int i = 0; i < rows; i++) {
                rowSum[i] = 0;
            }

            for (int right = left; right < cols; right++) {
                for (int i = 0; i < rows; i++) {
                    rowSum[i] += matrix[i][right];
                }

                for (int i = 0; i < rows; i++) {
                    int currentSum = 0;
                    for (int j = i; j < rows; j++) {
                        currentSum += rowSum[j];
                        if (currentSum <= k && currentSum > maxSum) {
                            maxSum = currentSum;
                        }
                    }
                }

            }
        }
    }
    return maxSum;
}