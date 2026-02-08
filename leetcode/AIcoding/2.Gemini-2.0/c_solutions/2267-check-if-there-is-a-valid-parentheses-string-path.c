#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool hasValidPath(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    if ((m + n - 1) % 2 != 0) return false;
    if (grid[0][0] == ')' || grid[m - 1][n - 1] == ')') return false;

    bool dp[m][n][m + n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < m + n; k++) {
                dp[i][j][k] = false;
            }
        }
    }

    dp[0][0][1] = (grid[0][0] == '(');

    for (int sum = 1; sum < m + n; sum++) {
        for (int i = 0; i < m; i++) {
            int j = sum - i;
            if (j < 0 || j >= n) continue;

            for (int k = 0; k < m + n; k++) {
                if (grid[i][j] == '(') {
                    if (k > 0) {
                        if (i > 0) dp[i][j][k] = dp[i][j][k] || dp[i - 1][j][k - 1];
                        if (j > 0) dp[i][j][k] = dp[i][j][k] || dp[i][j - 1][k - 1];
                    }
                } else {
                    if (i > 0) dp[i][j][k] = dp[i][j][k] || dp[i - 1][j][k + 1];
                    if (j > 0) dp[i][j][k] = dp[i][j][k] || dp[i][j - 1][k + 1];
                }
            }
        }
    }

    return dp[m - 1][n - 1][0];
}