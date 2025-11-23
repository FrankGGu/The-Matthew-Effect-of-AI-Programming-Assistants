#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindromeSubseq(char * s, int k){
    int n = strlen(s);
    int dp[n][n];
    memset(dp, 0, sizeof(dp));
    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }
    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j]) {
                dp[i][j] = dp[i + 1][j - 1] + 2;
            } else {
                dp[i][j] = (dp[i + 1][j] > dp[i][j - 1]) ? dp[i + 1][j] : dp[i][j - 1];
            }
        }
    }
    return (n - dp[0][n - 1] <= k) ? n : dp[0][n - 1] + k;
}