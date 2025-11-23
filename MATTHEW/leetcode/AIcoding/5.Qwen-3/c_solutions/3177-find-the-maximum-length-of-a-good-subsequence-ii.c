#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumLength(char *s, int k) {
    int n = strlen(s);
    int dp[10][1001];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 10; j++) {
            dp[j][i + 1] = dp[j][i];
        }
        int c = s[i] - '0';
        for (int j = 0; j < 10; j++) {
            if (j == c) {
                dp[j][i + 1] = fmax(dp[j][i + 1], dp[j][i] + 1);
            } else {
                dp[j][i + 1] = fmax(dp[j][i + 1], dp[j][i]);
            }
        }
    }

    int max_len = 0;
    for (int i = 0; i < 10; i++) {
        max_len = fmax(max_len, dp[i][n]);
    }
    return max_len;
}