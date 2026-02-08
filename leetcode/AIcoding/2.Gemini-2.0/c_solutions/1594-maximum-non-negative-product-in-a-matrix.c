#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProductPath(int** grid, int gridSize, int* gridColSize) {
    long long min_dp[gridSize][*gridColSize];
    long long max_dp[gridSize][*gridColSize];

    min_dp[0][0] = grid[0][0];
    max_dp[0][0] = grid[0][0];

    for (int i = 1; i < gridSize; i++) {
        min_dp[i][0] = min_dp[i - 1][0] * grid[i][0];
        max_dp[i][0] = max_dp[i - 1][0] * grid[i][0];
    }

    for (int j = 1; j < *gridColSize; j++) {
        min_dp[0][j] = min_dp[0][j - 1] * grid[0][j];
        max_dp[0][j] = max_dp[0][j - 1] * grid[0][j];
    }

    for (int i = 1; i < gridSize; i++) {
        for (int j = 1; j < *gridColSize; j++) {
            long long op1 = min_dp[i - 1][j] * grid[i][j];
            long long op2 = max_dp[i - 1][j] * grid[i][j];
            long long op3 = min_dp[i][j - 1] * grid[i][j];
            long long op4 = max_dp[i][j - 1] * grid[i][j];

            min_dp[i][j] = fmin(fmin(op1, op2), fmin(op3, op4));
            max_dp[i][j] = fmax(fmax(op1, op2), fmax(op3, op4));
        }
    }

    if (max_dp[gridSize - 1][*gridColSize - 1] < 0) {
        return -1;
    } else {
        return (int)(max_dp[gridSize - 1][*gridColSize - 1] % 1000000007);
    }
}