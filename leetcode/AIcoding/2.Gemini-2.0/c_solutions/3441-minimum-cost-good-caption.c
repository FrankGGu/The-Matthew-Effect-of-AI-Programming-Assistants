#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumCost(int *words, int wordsSize, int k) {
    int n = wordsSize;
    int dp[n + 1];
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        dp[i] = INT_MAX;
        for (int j = 1; j <= i; j++) {
            int cost = 0;
            int len = 0;
            for (int l = i - j; l < i; l++) {
                len += words[l];
                if (l < i - 1) {
                    len++;
                }
            }

            if (len <= k) {
                if (len == k) {
                    cost = 0;
                } else {
                    cost = (k - len) * (k - len);
                }

                if (dp[i - j] != INT_MAX && dp[i - j] + cost < dp[i]) {
                    dp[i] = dp[i - j] + cost;
                }
            }
        }
    }

    return dp[n];
}