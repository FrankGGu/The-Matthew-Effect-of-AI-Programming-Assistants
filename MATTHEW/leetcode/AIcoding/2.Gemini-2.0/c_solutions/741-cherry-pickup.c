#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cherryPickup(int** grid, int gridSize, int* gridColSize){
    int n = gridSize;
    int dp[n][n];
    memset(dp, -1, sizeof(dp));

    dp[0][0] = grid[0][0];

    for (int t = 1; t <= 2 * n - 2; t++) {
        int new_dp[n][n];
        memset(new_dp, -1, sizeof(new_dp));

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (dp[i][j] == -1) continue;

                for (int x = i; x <= i + 1; x++) {
                    for (int y = j; y <= j + 1; y++) {
                        if (x >= n || y >= n || grid[x][t - x] == -1 || grid[y][t - y] == -1) continue;

                        int cherries = dp[i][j];
                        cherries += grid[x][t - x];
                        if (x != y) cherries += grid[y][t - y];

                        new_dp[x][y] = (new_dp[x][y] > cherries) ? new_dp[x][y] : cherries;
                    }
                }
            }
        }
        memcpy(dp, new_dp, sizeof(dp));
    }

    return (dp[n - 1][n - 1] < 0) ? 0 : dp[n - 1][n - 1];
}