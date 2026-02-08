#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
    int dp[maxMove + 1][m][n];
    for (int k = 0; k <= maxMove; k++) {
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp[k][i][j] = 0;
            }
        }
    }
    int mod = 1000000007;
    int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    for (int k = 1; k <= maxMove; k++) {
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int d = 0; d < 4; d++) {
                    int prev_i = i - directions[d][0];
                    int prev_j = j - directions[d][1];
                    if (prev_i < 0 || prev_i >= m || prev_j < 0 || prev_j >= n) {
                        dp[k][i][j] = (dp[k][i][j] + 1) % mod;
                    } else {
                        dp[k][i][j] = (dp[k][i][j] + dp[k - 1][prev_i][prev_j]) % mod;
                    }
                }
            }
        }
    }
    return dp[maxMove][startRow][startColumn];
}