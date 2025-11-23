#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTime(char * s) {
    int n = strlen(s);
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    dp[0] = 0;
    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        if (s[i - 1] == '1') {
            dp[i] = (dp[i] < dp[i - 1] + 2) ? dp[i] : dp[i - 1] + 2;
        }
    }
    int result = dp[n];
    int right = 0;
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '1') {
            right += 2;
        } else {
            right++;
            right = (right < 0) ? 0 : right;
        }
        result = (result < dp[i] + right) ? result : dp[i] + right;
    }
    free(dp);
    return result;
}