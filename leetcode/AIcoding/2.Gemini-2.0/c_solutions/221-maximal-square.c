#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximalSquare(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        return 0;
    }

    int rows = matrixSize;
    int cols = *matrixColSize;
    int dp[rows][cols];
    int max_side = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == '1') {
                if (i == 0 || j == 0) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = fmin(fmin(dp[i - 1][j], dp[i][j - 1]), dp[i - 1][j - 1]) + 1;
                }
                if (dp[i][j] > max_side) {
                    max_side = dp[i][j];
                }
            } else {
                dp[i][j] = 0;
            }
        }
    }

    return max_side * max_side;
}