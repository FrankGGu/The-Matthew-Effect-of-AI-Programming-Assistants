#include <stdio.h>
#include <stdlib.h>

int minSideJumps(int* n, int nSize) {
    int dp[3] = {0, 1, 2};
    for (int i = 1; i < nSize; i++) {
        int new_dp[3];
        for (int j = 0; j < 3; j++) {
            if (n[i] == j + 1) {
                new_dp[j] = 1e9;
            } else {
                new_dp[j] = dp[j];
                for (int k = 0; k < 3; k++) {
                    if (k != j) {
                        new_dp[j] = fmin(new_dp[j], dp[k] + 1);
                    }
                }
            }
        }
        for (int j = 0; j < 3; j++) {
            dp[j] = new_dp[j];
        }
    }
    return fmin(fmin(dp[0], dp[1]), dp[2]);
}