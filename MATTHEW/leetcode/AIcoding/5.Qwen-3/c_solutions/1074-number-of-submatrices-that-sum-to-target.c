#include <stdio.h>
#include <stdlib.h>

int numSubmatrixSumTarget(int** matrix, int matrixSize, int* matrixColSize, int target) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int result = 0;

    for (int left = 0; left < cols; left++) {
        int* temp = (int*)calloc(rows, sizeof(int));
        for (int right = left; right < cols; right++) {
            for (int i = 0; i < rows; i++) {
                temp[i] += matrix[i][right];
            }

            int prefixSum = 0;
            int sumCount = 0;
            int* hash = (int*)calloc(rows + 1, sizeof(int));
            hash[0] = 1;

            for (int i = 0; i < rows; i++) {
                prefixSum += temp[i];
                if (hash[prefixSum - target] > 0) {
                    sumCount += hash[prefixSum - target];
                }
                hash[prefixSum]++;
            }

            free(hash);
            result += sumCount;
        }
        free(temp);
    }

    return result;
}