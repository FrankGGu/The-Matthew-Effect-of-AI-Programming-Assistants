#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getLength(int count) {
    if (count == 1) return 0;
    if (count < 10) return 1;
    if (count < 100) return 2;
    return 3;
}

int solve(char *s, int k, int start, int **dp) {
    if (k < 0) return INT_MAX / 2;
    if (start == strlen(s)) return 0;
    if (dp[start][k] != -1) return dp[start][k];

    int ans = solve(s, k - 1, start + 1, dp);
    int count = 0;
    int diff = 0;
    for (int i = start; i < strlen(s); i++) {
        if (s[i] == s[start]) {
            count++;
        } else {
            diff++;
        }
        if (diff > k) break;
        ans = fmin(ans, 1 + getLength(count) + solve(s, k - diff, i + 1, dp));
    }

    return dp[start][k] = ans;
}

int getLengthOfOptimalCompression(char *s, int k) {
    int n = strlen(s);
    int **dp = (int **)malloc(n * sizeof(int *));
    for (int i = 0; i < n; i++) {
        dp[i] = (int *)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = -1;
        }
    }

    int ans = solve(s, k, 0, dp);

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return ans;
}