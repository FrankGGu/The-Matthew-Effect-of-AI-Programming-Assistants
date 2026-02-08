#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubmatrices(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int count = 0;
    int prefixSum[rows + 1][cols + 1];

    for (int i = 0; i <= rows; i++) {
        for (int j = 0; j <= cols; j++) {
            prefixSum[i][j] = 0;
        }
    }

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + matrix[i - 1][j - 1];
        }
    }

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            for (int r = 1; r <= i; r++) {
                for (int c = 1; c <= j; c++) {
                    int sum = prefixSum[r][c];
                    if (sum <= k) {
                        count++;
                    }
                }
            }
        }
    }

    return count;
}