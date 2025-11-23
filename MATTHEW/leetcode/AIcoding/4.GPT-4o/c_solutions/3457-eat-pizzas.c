int maxPizzaSlices(int* slices, int slicesSize, int k) {
    int n = slicesSize / 3;
    int dp[2][k + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < 2; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = (j == 0) ? 0 : INT_MIN;
        }
    }

    for (int i = 0; i < slicesSize; i++) {
        for (int j = 1; j <= n; j++) {
            for (int l = k; l >= 1; l--) {
                if (i == 0 || l == 0) continue;
                dp[j % 2][l] = fmax(dp[j % 2][l], dp[(j - 1) % 2][l - 1] + slices[i]);
            }
        }
    }

    return fmax(dp[0][k], dp[1][k]);
}