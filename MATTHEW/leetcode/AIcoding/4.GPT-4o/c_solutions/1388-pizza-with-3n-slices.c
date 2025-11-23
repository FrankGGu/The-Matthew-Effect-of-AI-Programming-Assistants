int maxSizeSlices(int* slices, int slicesSize, int n) {
    int k = slicesSize / 3;
    int dp[2 * n + 1][k + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < slicesSize; i++) {
        for (int j = i < k ? i + 1 : k; j > 0; j--) {
            for (int m = n; m > 0; m--) {
                dp[m][j] = fmax(dp[m][j], dp[m - 1][j - 1] + slices[i]);
            }
        }
    }

    return dp[n][k];
}