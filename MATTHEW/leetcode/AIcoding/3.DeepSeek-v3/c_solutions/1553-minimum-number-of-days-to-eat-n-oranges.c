int minDays(int n) {
    if (n <= 1) return n;

    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = i;
    }

    for (int i = 1; i <= n; i++) {
        if (i % 2 == 0) {
            dp[i] = fmin(dp[i], dp[i - i / 2] + 1);
        }
        if (i % 3 == 0) {
            dp[i] = fmin(dp[i], dp[i - 2 * (i / 3)] + 1);
        }
        dp[i] = fmin(dp[i], dp[i - 1] + 1);
    }

    int result = dp[n];
    free(dp);
    return result;
}