#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxMoves(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        dp[i][0] = 0;
    }

    for (int j = 1; j < cols; j++) {
        for (int i = 0; i < rows; i++) {
            int maxVal = -1;
            if (i > 0 && grid[i][j] > grid[i-1][j-1]) {
                maxVal = dp[i-1][j-1];
            }
            if (i < rows-1 && grid[i][j] > grid[i+1][j-1]) {
                maxVal = fmax(maxVal, dp[i+1][j-1]);
            }
            if (grid[i][j] > grid[i][j-1]) {
                maxVal = fmax(maxVal, dp[i][j-1]);
            }
            dp[i][j] = (maxVal == -1) ? -1 : maxVal + 1;
        }
    }

    int result = 0;
    for (int i = 0; i < rows; i++) {
        if (dp[i][cols-1] > result) {
            result = dp[i][cols-1];
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}