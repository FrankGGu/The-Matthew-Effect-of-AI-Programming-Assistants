#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strangePrinter(char * s){
    int n = strlen(s);
    if (n == 0) return 0;

    int dp[101][101];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            dp[i][j] = INT_MAX;
            for (int k = i; k < j; k++) {
                int cost = dp[i][k] + dp[k + 1][j];
                if (s[k] == s[j]) {
                    cost--;
                }
                dp[i][j] = (dp[i][j] < cost) ? dp[i][j] : cost;
            }
        }
    }

    return dp[0][n - 1];
}