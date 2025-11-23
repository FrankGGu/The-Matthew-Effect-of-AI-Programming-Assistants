#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubmatrixSumTarget(int** matrix, int matrixSize, int* matrixColSize, int target) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int count = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 1; j < n; j++) {
            matrix[i][j] += matrix[i][j - 1];
        }
    }

    for (int c1 = 0; c1 < n; c1++) {
        for (int c2 = c1; c2 < n; c2++) {
            int sum = 0;
            int prefixSum[101] = {0};
            prefixSum[0] = 1;

            for (int row = 0; row < m; row++) {
                sum = 0;
                if (c1 == 0) {
                    sum = matrix[row][c2];
                } else {
                    sum = matrix[row][c2] - matrix[row][c1 - 1];
                }

                int need = sum - target;
                if (need >= -10000 && need <= 10000){
                    count += prefixSum[need + 5000];
                }
                prefixSum[sum + 5000]++;
            }
            memset(prefixSum, 0, sizeof(prefixSum));
            prefixSum[0] = 1;
        }
    }

    return count;
}