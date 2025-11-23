int minimumWhiteTiles(int* A, int ASize, int carpetLen) {
    int n = ASize;
    int dp[n + 1];
    memset(dp, 0, sizeof(dp));
    int prefixSum[n + 1];
    prefixSum[0] = 0;

    for (int i = 1; i <= n; i++) {
        prefixSum[i] = prefixSum[i - 1] + A[i - 1];
    }

    int result = prefixSum[n];

    for (int i = 0; i < n; i++) {
        int end = i + carpetLen - 1;
        if (end >= n) end = n - 1;
        int covered = prefixSum[end + 1] - prefixSum[i];
        result = result - covered;
        dp[end + 1] = fmax(dp[end + 1], result);
        if (i > 0) {
            dp[end + 1] = fmax(dp[end + 1], dp[i] - covered);
        }
    }

    return result - dp[n];
}