#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * longestPalindrome(char * s){
    int n = strlen(s);
    if (n < 2) {
        return s;
    }

    int maxLen = 1;
    int start = 0;
    int dp[n][n];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i + 1]) {
            dp[i][i + 1] = 1;
            start = i;
            maxLen = 2;
        }
    }

    for (int len = 3; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j] && dp[i + 1][j - 1]) {
                dp[i][j] = 1;
                if (len > maxLen) {
                    maxLen = len;
                    start = i;
                }
            }
        }
    }

    char *result = (char *)malloc(maxLen + 1);
    strncpy(result, s + start, maxLen);
    result[maxLen] = '\0';

    return result;
}