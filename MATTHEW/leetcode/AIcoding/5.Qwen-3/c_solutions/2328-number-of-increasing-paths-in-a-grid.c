#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int row;
    int col;
} Pair;

int cmp(const void *a, const void *b) {
    return ((Pair *)a)->row - ((Pair *)b)->row;
}

int dfs(int **grid, int rows, int cols, int i, int j, int **dp) {
    if (dp[i][j] != -1) return dp[i][j];
    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int result = 1;
    for (int k = 0; k < 4; k++) {
        int ni = i + directions[k][0];
        int nj = j + directions[k][1];
        if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && grid[ni][nj] > grid[i][j]) {
            result += dfs(grid, rows, cols, ni, nj, dp);
        }
    }
    dp[i][j] = result;
    return result;
}

int countPaths(int **grid, int rows, int cols) {
    int **dp = (int **)malloc(rows * sizeof(int *));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int *)malloc(cols * sizeof(int));
        memset(dp[i], -1, cols * sizeof(int));
    }

    int total = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            total += dfs(grid, rows, cols, i, j, dp);
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);
    return total;
}

int numIncreasingPaths(int** grid, int gridSize, int* gridColSize) {
    return countPaths(grid, gridSize, gridColSize[0]);
}