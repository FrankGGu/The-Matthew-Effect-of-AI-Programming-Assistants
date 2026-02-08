#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isMatch(char *s, char *p) {
    int m = strlen(s), n = strlen(p);
    bool **dp = (bool **)malloc((m + 1) * sizeof(bool *));
    for (int i = 0; i <= m; i++) {
        dp[i] = (bool *)malloc((n + 1) * sizeof(bool));
        memset(dp[i], false, (n + 1) * sizeof(bool));
    }
    dp[0][0] = true;
    for (int i = 0; i < n; i++) {
        if (p[i] == '*' && i > 0) {
            dp[0][i + 1] = dp[0][i - 1];
        }
    }
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (p[j - 1] == '*') {
                dp[i][j] = dp[i][j - 1] || dp[i][j - 2] || (dp[i - 1][j] && (s[i - 1] == p[j - 2] || p[j - 2] == '.'));
            } else {
                dp[i][j] = (s[i - 1] == p[j - 1] || p[j - 1] == '.') && dp[i - 1][j - 1];
            }
        }
    }
    bool result = dp[m][n];
    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}