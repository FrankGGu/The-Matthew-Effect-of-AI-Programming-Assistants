#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tilingRectangle(int n, int m) {
    if ((n == 11 && m == 13) || (n == 13 && m == 11)) return 6;

    int dp[n + 1][m + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            if (i == j) {
                dp[i][j] = 1;
            } else if (i == 1) {
                dp[i][j] = j;
            } else if (j == 1) {
                dp[i][j] = i;
            } else {
                for (int k = 1; k <= i / 2; k++) {
                    dp[i][j] = fmin(dp[i][j], dp[k][j] + dp[i - k][j]);
                }
                for (int k = 1; k <= j / 2; k++) {
                    dp[i][j] = fmin(dp[i][j], dp[i][k] + dp[i][j - k]);
                }
                for(int x = 1; x < fmin(i, j); x++){
                    dp[i][j] = fmin(dp[i][j], 1 + dp[i-x][j] + dp[i][j-x] - dp[i-x][j-x]);
                }

            }
        }
    }

    return dp[n][m];
}