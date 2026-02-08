#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int** grid;
    int rows;
    int cols;
} Grid;

int maxScore(Grid* grid) {
    int rows = grid->rows;
    int cols = grid->cols;
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    dp[0][0] = grid->grid[0][0];

    for (int j = 1; j < cols; j++) {
        dp[0][j] = dp[0][j - 1] + grid->grid[0][j];
    }

    for (int i = 1; i < rows; i++) {
        dp[i][0] = dp[i - 1][0] + grid->grid[i][0];
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 1; j < cols; j++) {
            dp[i][j] = grid->grid[i][j] + (dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1]);
        }
    }

    int result = dp[rows - 1][cols - 1];

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}

int maxScoreGrid(int** grid, int gridSize, int* gridColSize) {
    Grid g;
    g.grid = grid;
    g.rows = gridSize;
    g.cols = gridColSize[0];
    return maxScore(&g);
}