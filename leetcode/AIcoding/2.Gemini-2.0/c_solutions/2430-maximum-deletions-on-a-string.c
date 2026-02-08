#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int deleteString(char *s) {
    int n = strlen(s);
    int dp[n];
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
    }

    for (int i = n - 2; i >= 0; i--) {
        for (int j = 1; i + 2 * j <= n; j++) {
            if (strncmp(s + i, s + i + j, j) == 0) {
                dp[i] = fmax(dp[i], dp[i + j] + 1);
            }
        }
    }

    return dp[0];
}