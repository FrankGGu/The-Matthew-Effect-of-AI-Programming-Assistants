#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxSumSubmatrix(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int result = INT_MIN;

    for (int left = 0; left < cols; left++) {
        int* temp = (int*)malloc(rows * sizeof(int));
        for (int i = 0; i < rows; i++) {
            temp[i] = 0;
        }

        for (int right = left; right < cols; right++) {
            for (int i = 0; i < rows; i++) {
                temp[i] += matrix[i][right];
            }

            int* prefixSums = (int*)malloc((rows + 1) * sizeof(int));
            prefixSums[0] = 0;
            for (int i = 0; i < rows; i++) {
                prefixSums[i + 1] = prefixSums[i] + temp[i];
            }

            int currentMax = INT_MIN;
            for (int i = 0; i < rows; i++) {
                for (int j = i + 1; j <= rows; j++) {
                    int sum = prefixSums[j] - prefixSums[i];
                    if (sum <= k && sum > currentMax) {
                        currentMax = sum;
                    }
                }
            }

            if (currentMax > result) {
                result = currentMax;
            }

            free(prefixSums);
        }
        free(temp);
    }

    return result;
}