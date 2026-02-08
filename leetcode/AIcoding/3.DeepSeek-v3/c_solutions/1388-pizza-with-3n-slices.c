int maxSizeSlices(int* slices, int slicesSize) {
    int n = slicesSize / 3;
    return fmax(calculate(slices, slicesSize - 1, n), calculate(slices + 1, slicesSize - 1, n));
}

int calculate(int* slices, int size, int n) {
    int dp[size + 1][n + 1];
    for (int i = 0; i <= size; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= size; i++) {
        for (int j = 1; j <= n; j++) {
            if (i == 1) {
                dp[i][j] = slices[0];
            } else {
                dp[i][j] = fmax(dp[i - 1][j], dp[i - 2][j - 1] + slices[i - 1]);
            }
        }
    }
    return dp[size][n];
}