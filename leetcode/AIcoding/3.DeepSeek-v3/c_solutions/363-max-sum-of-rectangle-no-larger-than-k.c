#include <stdlib.h>
#include <string.h>
#include <limits.h>

int maxSumSubmatrix(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int maxSum = INT_MIN;

    for (int left = 0; left < cols; left++) {
        int* rowSum = (int*)calloc(rows, sizeof(int));
        for (int right = left; right < cols; right++) {
            for (int i = 0; i < rows; i++) {
                rowSum[i] += matrix[i][right];
            }

            for (int top = 0; top < rows; top++) {
                int sum = 0;
                for (int bottom = top; bottom < rows; bottom++) {
                    sum += rowSum[bottom];
                    if (sum <= k && sum > maxSum) {
                        maxSum = sum;
                    }
                }
            }
        }
        free(rowSum);
    }

    return maxSum;
}