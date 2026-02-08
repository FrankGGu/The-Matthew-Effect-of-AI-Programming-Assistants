#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minInsertions(char * s){
    int n = strlen(s);
    int dp[n][n];

    for (int i = 0; i < n; i++) {
        dp[i][i] = 0;
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j]) {
                dp[i][j] = dp[i + 1][j - 1];
            } else {
                dp[i][j] = 1 + (dp[i + 1][j] < dp[i][j - 1] ? dp[i + 1][j] : dp[i][j - 1]);
            }
        }
    }

    return dp[0][n - 1];
}