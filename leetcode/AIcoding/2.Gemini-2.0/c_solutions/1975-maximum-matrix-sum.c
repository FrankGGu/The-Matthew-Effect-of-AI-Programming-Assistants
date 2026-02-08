#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maxMatrixSum(int** matrix, int matrixSize, int* matrixColSize) {
    long long sum = 0;
    int neg_count = 0;
    int min_abs = 100001;

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixColSize[i]; j++) {
            int val = matrix[i][j];
            sum += abs(val);
            if (val < 0) {
                neg_count++;
            }
            if (abs(val) < min_abs) {
                min_abs = abs(val);
            }
        }
    }

    if (neg_count % 2 == 0) {
        return sum;
    } else {
        return sum - 2 * min_abs;
    }
}