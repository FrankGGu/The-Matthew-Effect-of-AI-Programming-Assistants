#include <stdio.h>
#include <stdlib.h>

long long maximumMatrixSum(int** matrix, int matrixSize, int* matrixColSize) {
    long long total = 0;
    long long minAbs = 1LL << 60;
    int negativeCount = 0;

    for (int i = 0; i < matrixSize; ++i) {
        for (int j = 0; j < matrixColSize[i]; ++j) {
            long long val = matrix[i][j];
            if (val < 0) {
                negativeCount++;
                val = -val;
            }
            total += val;
            if (val < minAbs) {
                minAbs = val;
            }
        }
    }

    if (negativeCount % 2 == 0) {
        return total;
    } else {
        return total - 2 * minAbs;
    }
}