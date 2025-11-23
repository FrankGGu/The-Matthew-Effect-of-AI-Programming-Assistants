int mergeStones(int* stones, int stonesSize, int k) {
    if ((stonesSize - 1) % (k - 1) != 0) return -1;

    int n = stonesSize;
    int prefix[n + 1];
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + stones[i];
    }

    int dp[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = k; len <= n; len++) {
        for (int i = 0; i + len <= n; i++) {
            int j = i + len - 1;
            dp[i][j] = INT_MAX;
            for (int mid = i; mid < j; mid += k - 1) {
                dp[i][j] = fmin(dp[i][j], dp[i][mid] + dp[mid + 1][j]);
            }
            if ((j - i) % (k - 1) == 0) {
                dp[i][j] += prefix[j + 1] - prefix[i];
            }
        }
    }

    return dp[0][n - 1];
}