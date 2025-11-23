#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindromeSubseq(char* s, int k) {
    int n = strlen(s);
    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
        memset(dp[i], 0, (n + 1) * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            if (s[i] == s[j]) {
                dp[i][j] = 2 + dp[i + 1][j - 1];
            } else {
                dp[i][j] = fmax(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    int maxLen = dp[0][n - 1];
    int res = maxLen;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int l = j - i + 1;
            int changes = l - dp[i][j];
            if (changes <= k) {
                res = fmax(res, l);
            }
        }
    }

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return res;
}