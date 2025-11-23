#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countPalindromicSubsequences(char *s) {
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
                int low = i + 1;
                int high = j - 1;

                while (low <= high && s[low] != s[i]) {
                    low++;
                }
                while (low <= high && s[high] != s[i]) {
                    high--;
                }

                if (low > high) {
                    dp[i][j] = (2LL * dp[i + 1][j - 1] + 2) % MOD;
                } else if (low == high) {
                    dp[i][j] = (2LL * dp[i + 1][j - 1] + 1) % MOD;
                } else {
                    dp[i][j] = (2LL * dp[i + 1][j - 1] - dp[low + 1][high - 1] + MOD) % MOD;
                }
            } else {
                dp[i][j] = ((long long)dp[i][j - 1] + dp[i + 1][j] - dp[i + 1][j - 1] + MOD) % MOD;
            }
        }
    }

    return dp[0][n - 1];
}