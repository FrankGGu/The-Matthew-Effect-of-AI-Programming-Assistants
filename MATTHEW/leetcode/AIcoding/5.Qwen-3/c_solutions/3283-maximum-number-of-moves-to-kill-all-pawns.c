#include <stdio.h>
#include <stdlib.h>

int maxMoves(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int dp[rows][cols];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dp[i][j] = 0;
        }
    }
    for (int j = cols - 1; j >= 0; j--) {
        for (int i = 0; i < rows; i++) {
            if (grid[i][j] == 1) {
                int maxMove = 0;
                if (i > 0 && j + 1 < cols && grid[i - 1][j + 1] == 1) {
                    maxMove = fmax(maxMove, dp[i - 1][j + 1]);
                }
                if (j + 1 < cols && grid[i][j + 1] == 1) {
                    maxMove = fmax(maxMove, dp[i][j + 1]);
                }
                if (i < rows - 1 && j + 1 < cols && grid[i + 1][j + 1] == 1) {
                    maxMove = fmax(maxMove, dp[i + 1][j + 1]);
                }
                dp[i][j] = maxMove + 1;
            }
        }
    }
    int result = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                result = fmax(result, dp[i][j]);
            }
        }
    }
    return result;
}