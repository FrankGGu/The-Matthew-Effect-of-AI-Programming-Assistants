#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mergeStones(int* stones, int stonesSize, int k) {
    if ((stonesSize - 1) % (k - 1) != 0) {
        return -1;
    }

    int prefixSum[stonesSize + 1];
    prefixSum[0] = 0;
    for (int i = 0; i < stonesSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    int dp[stonesSize][stonesSize];
    for (int i = 0; i < stonesSize; i++) {
        for (int j = 0; j < stonesSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = k; len <= stonesSize; len++) {
        for (int i = 0; i <= stonesSize - len; i++) {
            int j = i + len - 1;
            dp[i][j] = INT_MAX;
            for (int m = i; m < j; m += (k - 1)) {
                dp[i][j] = (dp[i][j] < dp[i][m] + dp[m + 1][j] ? dp[i][j] : dp[i][m] + dp[m + 1][j]);
            }
            if ((len - 1) % (k - 1) == 0) {
                dp[i][j] += prefixSum[j + 1] - prefixSum[i];
            }
        }
    }

    return dp[0][stonesSize - 1];
}