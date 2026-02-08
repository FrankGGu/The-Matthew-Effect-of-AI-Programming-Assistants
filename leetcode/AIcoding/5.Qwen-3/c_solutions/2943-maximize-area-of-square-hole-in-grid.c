#include <stdio.h>
#include <stdlib.h>

int maxArea(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    int maxSide = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                if (i == 0 || j == 0) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = fmin(fmin(dp[i-1][j], dp[i][j-1]), dp[i-1][j-1]) + 1;
                }
                maxSide = fmax(maxSide, dp[i][j]);
            } else {
                dp[i][j] = 0;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxSide * maxSide;
}