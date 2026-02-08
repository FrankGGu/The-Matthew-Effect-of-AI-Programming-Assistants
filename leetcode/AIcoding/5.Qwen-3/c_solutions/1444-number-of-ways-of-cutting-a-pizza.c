#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dp[10][10][10];
int memo[10][10][10];

int hasApple(char** grid, int rows, int cols, int r1, int c1, int r2, int c2) {
    for (int i = r1; i <= r2; i++) {
        for (int j = c1; j <= c2; j++) {
            if (grid[i][j] == 'A') return 1;
        }
    }
    return 0;
}

int solve(char** grid, int rows, int cols, int k, int r, int c) {
    if (k == 0) return 1;
    if (memo[r][c][k] != -1) return memo[r][c][k];

    int res = 0;
    for (int i = r + 1; i < rows; i++) {
        if (hasApple(grid, rows, cols, r, c, i - 1, cols - 1)) {
            res += solve(grid, rows, cols, k - 1, i, c);
        }
    }
    for (int j = c + 1; j < cols; j++) {
        if (hasApple(grid, rows, cols, r, c, rows - 1, j - 1)) {
            res += solve(grid, rows, cols, k - 1, r, j);
        }
    }
    memo[r][c][k] = res;
    return res;
}

int ways(char** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    memset(memo, -1, sizeof(memo));
    return solve(grid, rows, cols, 2, 0, 0);
}