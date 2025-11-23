#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int palindromeCost(char *s, int i, int j) {
    int cost = 0;
    while (i < j) {
        if (s[i] != s[j]) {
            cost++;
        }
        i++;
        j--;
    }
    return cost;
}

int palindromePartition(char *s, int k) {
    int n = strlen(s);
    int dp[n + 1][k + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            for (int l = 1; l <= i; l++) {
                int cost = palindromeCost(s, i - l, i - 1);
                if (dp[i - l][j - 1] != INT_MAX) {
                    dp[i][j] = fmin(dp[i][j], dp[i - l][j - 1] + cost);
                }
            }
        }
    }

    return dp[n][k];
}