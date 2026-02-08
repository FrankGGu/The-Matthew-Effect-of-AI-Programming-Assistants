#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestValidParentheses(char *s) {
    int max_len = 0;
    int n = strlen(s);
    int *dp = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = 0;
    }
    for (int i = 1; i < n; i++) {
        if (s[i] == ')') {
            if (s[i - 1] == '(') {
                dp[i] = (i >= 2 ? dp[i - 2] : 0) + 2;
            } else if (i - dp[i - 1] - 1 >= 0 && s[i - dp[i - 1] - 1] == '(') {
                dp[i] = dp[i - 1] + 2;
                if (i - dp[i - 1] - 2 >= 0) {
                    dp[i] += dp[i - dp[i - 1] - 2];
                }
            }
        }
        max_len = (dp[i] > max_len) ? dp[i] : max_len;
    }
    free(dp);
    return max_len;
}