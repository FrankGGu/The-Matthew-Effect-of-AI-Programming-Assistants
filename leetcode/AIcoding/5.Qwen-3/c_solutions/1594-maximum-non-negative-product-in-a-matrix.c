#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxNonNegativeProduct(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** max_dp = (int**)malloc(rows * sizeof(int*));
    int** min_dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        max_dp[i] = (int*)malloc(cols * sizeof(int));
        min_dp[i] = (int*)malloc(cols * sizeof(int));
    }

    max_dp[0][0] = grid[0][0];
    min_dp[0][0] = grid[0][0];

    for (int j = 1; j < cols; j++) {
        max_dp[0][j] = max_dp[0][j - 1] * grid[0][j];
        min_dp[0][j] = min_dp[0][j - 1] * grid[0][j];
    }

    for (int i = 1; i < rows; i++) {
        max_dp[i][0] = max_dp[i - 1][0] * grid[i][0];
        min_dp[i][0] = min_dp[i - 1][0] * grid[i][0];
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 1; j < cols; j++) {
            int temp_max = max(max_dp[i - 1][j], max_dp[i][j - 1]);
            int temp_min = min(min_dp[i - 1][j], min_dp[i][j - 1]);
            max_dp[i][j] = max(temp_max * grid[i][j], temp_min * grid[i][j]);
            min_dp[i][j] = min(temp_max * grid[i][j], temp_min * grid[i][j]);
        }
    }

    int result = max_dp[rows - 1][cols - 1];
    for (int i = 0; i < rows; i++) {
        free(max_dp[i]);
        free(min_dp[i]);
    }
    free(max_dp);
    free(min_dp);
    return result;
}