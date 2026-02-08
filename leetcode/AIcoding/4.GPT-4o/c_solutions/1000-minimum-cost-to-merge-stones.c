#include <limits.h>

int mergeStones(int* stones, int stonesSize, int K) {
    if (stonesSize == 1) return 0;
    if ((stonesSize - 1) % (K - 1) != 0) return -1;

    int dp[stonesSize][stonesSize], sum[stonesSize + 1];
    for (int i = 0; i < stonesSize; i++) {
        sum[i + 1] = sum[i] + stones[i];
        for (int j = 0; j < stonesSize; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int len = K; len <= stonesSize; len++) {
        for (int i = 0; i + len - 1 < stonesSize; i++) {
            int j = i + len - 1;
            if (len == K) {
                dp[i][j] = sum[j + 1] - sum[i];
            } else {
                for (int m = i; m < j; m += K - 1) {
                    dp[i][j] = fmin(dp[i][j], dp[i][m] + dp[m + 1][j]);
                }
            }
            if ((len - 1) % (K - 1) == 0) {
                dp[i][j] += sum[j + 1] - sum[i];
            }
        }
    }
    return dp[0][stonesSize - 1];
}