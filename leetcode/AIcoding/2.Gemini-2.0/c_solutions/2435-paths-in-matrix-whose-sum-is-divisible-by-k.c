#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfPaths(int** grid, int gridSize, int* gridColSize, int k) {
    int m = gridSize;
    int n = gridColSize[0];
    int dp[m][n][k];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int l = 0; l < k; l++) {
                dp[i][j][l] = 0;
            }
        }
    }

    dp[0][0][grid[0][0] % k] = 1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int l = 0; l < k; l++) {
                if (dp[i][j][l] > 0) {
                    int new_val = (l + grid[i][j]) % k;
                    if (i + 1 < m) {
                        dp[i + 1][j][(l + grid[i+1][j]) % k] = (dp[i + 1][j][(l + grid[i+1][j]) % k] + dp[i][j][l]) % 1000000007;
                    }
                    if (j + 1 < n) {
                        dp[i][j + 1][(l + grid[i][j+1]) % k] = (dp[i][j + 1][(l + grid[i][j+1]) % k] + dp[i][j][l]) % 1000000007;
                    }
                }
            }
        }
    }

    return dp[m - 1][n - 1][0];
}