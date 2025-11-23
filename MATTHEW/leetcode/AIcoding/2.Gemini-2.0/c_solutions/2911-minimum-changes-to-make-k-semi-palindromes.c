#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int solve(char* s, int k) {
    int n = strlen(s);
    int cost[n + 1][n + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            cost[i][j] = 0;
        }
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 1; i <= n - len + 1; i++) {
            int j = i + len - 1;
            int changes = 0;
            for (int l = i, r = j; l < r; l++, r--) {
                if (s[l - 1] != s[r - 1]) {
                    changes++;
                }
            }
            cost[i][j] = changes;
        }
    }

    int dp[n + 1][k + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 1e9;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            for (int l = 1; l <= i; l++) {
                dp[i][j] = min(dp[i][j], dp[l - 1][j - 1] + cost[l][i]);
            }
        }
    }

    return dp[n][k];
}