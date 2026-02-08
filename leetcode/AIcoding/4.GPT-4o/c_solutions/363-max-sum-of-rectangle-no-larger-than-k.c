#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>
#include <string.h>

int maxSumSubmatrix(int** matrix, int matrixSize, int* matrixColSize, int k) {
    if (matrixSize == 0 || *matrixColSize == 0) return 0;
    int maxSum = INT_MIN;
    int rows = matrixSize, cols = *matrixColSize;

    for (int left = 0; left < cols; left++) {
        int* sums = (int*)calloc(rows, sizeof(int));
        for (int right = left; right < cols; right++) {
            for (int i = 0; i < rows; i++) {
                sums[i] += matrix[i][right];
            }

            // Find the maximum sum no larger than k using a set
            int currSum = 0;
            int* prefix = (int*)calloc(rows + 1, sizeof(int));
            prefix[0] = 0;

            for (int i = 0; i < rows; i++) {
                currSum += sums[i];
                prefix[i + 1] = currSum;
            }

            for (int i = 0; i < rows + 1; i++) {
                for (int j = 0; j < i; j++) {
                    int areaSum = prefix[i] - prefix[j];
                    if (areaSum <= k) {
                        maxSum = maxSum > areaSum ? maxSum : areaSum;
                    }
                }
            }

            free(prefix);
        }
        free(sums);
    }

    return maxSum;
}