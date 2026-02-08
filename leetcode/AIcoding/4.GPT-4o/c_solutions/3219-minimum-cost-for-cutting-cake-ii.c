int minCost(int* cut, int cutSize, int length) {
    int dp[cutSize + 2][cutSize + 2];
    for (int i = 0; i <= cutSize + 1; i++) {
        for (int j = 0; j <= cutSize + 1; j++) {
            dp[i][j] = 0;
        }
    }
    cut[cutSize] = 0;
    cut[cutSize + 1] = length;
    cutSize += 2;
    for (int len = 2; len < cutSize; len++) {
        for (int i = 0; i + len < cutSize; i++) {
            int j = i + len;
            dp[i][j] = INT_MAX;
            for (int k = i + 1; k < j; k++) {
                dp[i][j] = fmin(dp[i][j], dp[i][k] + dp[k][j] + cut[j] - cut[i]);
            }
        }
    }
    return dp[0][cutSize - 1];
}