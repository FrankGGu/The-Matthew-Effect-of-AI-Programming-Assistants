int maxSumAfterPartitioning(int* A, int ASize, int K) {
    int* dp = (int*)malloc((ASize + 1) * sizeof(int));
    dp[0] = 0;
    for (int i = 1; i <= ASize; i++) {
        int max_val = 0;
        for (int k = 1; k <= K && i - k >= 0; k++) {
            max_val = fmax(max_val, A[i - k]);
            dp[i] = fmax(dp[i], dp[i - k] + max_val * k);
        }
    }
    int result = dp[ASize];
    free(dp);
    return result;
}