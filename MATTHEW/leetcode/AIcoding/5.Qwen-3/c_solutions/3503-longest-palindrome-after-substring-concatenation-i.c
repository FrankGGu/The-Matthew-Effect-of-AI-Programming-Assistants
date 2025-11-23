#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindrome(char* s, int k) {
    int n = strlen(s);
    int maxLen = 0;
    int* dp = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (s[i] == s[j] && i - j + 1 <= k) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
        maxLen = fmax(maxLen, dp[i]);
    }

    free(dp);
    return maxLen;
}