#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubsequence(int n, int* groups, int groupsSize, int* values, int valuesSize) {
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 1;
    }

    int maxLen = 1;
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (groups[i] != groups[j]) {
                dp[i + 1] = (dp[i + 1] > dp[j + 1] + 1) ? dp[i + 1] : (dp[j + 1] + 1);
            } else {
                dp[i + 1] = (dp[i + 1] > dp[j + 1]) ? dp[i + 1] : dp[j + 1];
            }
        }
        maxLen = (maxLen > dp[i + 1]) ? maxLen : dp[i + 1];
    }
    return maxLen;
}