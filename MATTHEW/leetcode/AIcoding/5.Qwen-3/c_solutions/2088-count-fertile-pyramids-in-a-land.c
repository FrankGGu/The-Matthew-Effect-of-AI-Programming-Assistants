#include <stdio.h>
#include <stdlib.h>

int countPyramids(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)calloc(cols, sizeof(int));
    }

    for (int i = rows - 2; i >= 0; i--) {
        for (int j = 1; j < cols - 1; j++) {
            if (grid[i][j] == 1) {
                dp[i][j] = 1 + (dp[i+1][j-1] > 0 ? dp[i+1][j-1] : 0);
                dp[i][j] = 1 + (dp[i+1][j] > 0 ? dp[i+1][j] : 0);
                dp[i][j] = 1 + (dp[i+1][j+1] > 0 ? dp[i+1][j+1] : 0);
            }
        }
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (dp[i][j] >= 2) {
                count += dp[i][j] - 1;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return count;
}