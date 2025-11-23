#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindrome(char* s, int k) {
    int n = strlen(s);
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            if (s[i] == s[j]) {
                if (length == 2) {
                    dp[i][j] = 2;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                }
            } else {
                dp[i][j] = 0;
            }
        }
    }

    int max_len = 0;
    for (int i = 0; i < n - k + 1; i++) {
        for (int j = i + k - 1; j < n; j++) {
            if (dp[i][j] > max_len) {
                max_len = dp[i][j];
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return max_len;
}