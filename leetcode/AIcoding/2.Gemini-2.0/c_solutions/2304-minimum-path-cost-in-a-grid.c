#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPathCost(int** grid, int gridSize, int* gridColSize, int** moveCost, int moveCostSize, int* moveCostColSize) {
    int n = gridSize;
    int m = gridColSize[0];
    int dp[n][m];

    for (int j = 0; j < m; j++) {
        dp[0][j] = grid[0][j];
    }

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < m; j++) {
            dp[i][j] = INT_MAX;
            for (int k = 0; k < m; k++) {
                int cost = dp[i - 1][k] + moveCost[grid[i - 1][k]][j] + grid[i][j];
                if (cost < dp[i][j]) {
                    dp[i][j] = cost;
                }
            }
        }
    }

    int min_cost = INT_MAX;
    for (int j = 0; j < m; j++) {
        if (dp[n - 1][j] < min_cost) {
            min_cost = dp[n - 1][j];
        }
    }

    return min_cost;
}