#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxMoves(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int max_moves = 0;
    int dp[rows][cols];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dp[i][j] = 0;
        }
    }

    for (int j = 0; j < cols - 1; j++) {
        for (int i = 0; i < rows; i++) {
            if (dp[i][j] == j || j == 0) {
                if (i > 0 && grid[i - 1][j + 1] > grid[i][j]) {
                    dp[i - 1][j + 1] = (dp[i - 1][j + 1] > j + 1) ? dp[i - 1][j + 1] : j + 1;
                    max_moves = (max_moves > j + 1) ? max_moves : j + 1;
                }
                if (grid[i][j + 1] > grid[i][j]) {
                    dp[i][j + 1] = (dp[i][j + 1] > j + 1) ? dp[i][j + 1] : j + 1;
                    max_moves = (max_moves > j + 1) ? max_moves : j + 1;
                }
                if (i < rows - 1 && grid[i + 1][j + 1] > grid[i][j]) {
                    dp[i + 1][j + 1] = (dp[i + 1][j + 1] > j + 1) ? dp[i + 1][j + 1] : j + 1;
                    max_moves = (max_moves > j + 1) ? max_moves : j + 1;
                }
            }
        }
    }

    return max_moves;
}