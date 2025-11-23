#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAXN 100

int dp[MAXN][MAXN][MAXN];

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(int** grid, int n, int x1, int y1, int x2, int y2) {
    if (x1 >= n || y1 >= n || x2 >= n || y2 >= n) return -INT_MAX;
    if (x1 == n - 1 && y1 == n - 1) return grid[x1][y1];
    if (x2 == n - 1 && y2 == n - 1) return grid[x2][y2];
    if (dp[x1][y1][x2] != -1) return dp[x1][y1][x2];

    int y2 = x1 + y1 - x2;
    if (y2 < 0 || y2 >= n) return -INT_MAX;

    int res = -INT_MAX;
    int val = grid[x1][y1];
    if (x1 != x2 || y1 != y2) val += grid[x2][y2];

    res = max(res, dfs(grid, n, x1 + 1, y1, x2 + 1, y2));
    res = max(res, dfs(grid, n, x1 + 1, y1, x2, y2 + 1));
    res = max(res, dfs(grid, n, x1, y1 + 1, x2 + 1, y2));
    res = max(res, dfs(grid, n, x1, y1 + 1, x2, y2 + 1));

    dp[x1][y1][x2] = val + res;
    return dp[x1][y1][x2];
}

int cherryPickup(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                dp[i][j][k] = -1;
            }
        }
    }
    return dfs(grid, n, 0, 0, 0, 0);
}