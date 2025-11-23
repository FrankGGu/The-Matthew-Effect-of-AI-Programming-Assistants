#include <string.h>
#include <limits.h>

int minChanges(char* s, int k) {
    int n = strlen(s);
    int cost[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int len = j - i + 1;
            int c = 0;
            for (int l = 0; l < len / 2; l++) {
                if (s[i + l] != s[j - l]) {
                    c++;
                }
            }
            cost[i][j] = c;
        }
    }

    int dp[k + 1][n + 1];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = INT_MAX / 2;
        }
    }
    dp[0][0] = 0;

    for (int i = 1; i <= k; i++) {
        for (int j = i; j <= n; j++) {
            for (int p = i - 1; p < j; p++) {
                if (dp[i - 1][p] != INT_MAX / 2) {
                    dp[i][j] = fmin(dp[i][j], dp[i - 1][p] + cost[p][j - 1]);
                }
            }
        }
    }

    return dp[k][n];
}