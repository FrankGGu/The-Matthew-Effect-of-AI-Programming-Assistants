#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int eggDrop(int n) {
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = i;
    }

    for (int i = 2; i <= 2; i++) {
        int new_dp[n + 1];
        new_dp[0] = 0;
        for (int j = 1; j <= n; j++) {
            int min_val = INT_MAX;
            for (int k = 1; k <= j; k++) {
                int val = 1 + (int)fmax((double)dp[k - 1], (double)new_dp[j - k]);
                if (val < min_val) {
                    min_val = val;
                }
            }
            new_dp[j] = min_val;
        }

        for (int k = 0; k <= n; k++)
        {
            dp[k] = new_dp[k];
        }

    }

    return dp[n];
}