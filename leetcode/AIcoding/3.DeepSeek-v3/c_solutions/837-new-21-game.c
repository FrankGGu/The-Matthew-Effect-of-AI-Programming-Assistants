double new21Game(int n, int k, int maxPts) {
    if (k == 0 || n >= k + maxPts) return 1.0;

    double dp[n + 1];
    for (int i = 0; i <= n; i++) dp[i] = 0.0;

    dp[0] = 1.0;
    double sum = 1.0;
    double result = 0.0;

    for (int i = 1; i <= n; i++) {
        dp[i] = sum / maxPts;
        if (i < k) {
            sum += dp[i];
        } else {
            result += dp[i];
        }
        if (i >= maxPts) {
            sum -= dp[i - maxPts];
        }
    }

    return result;
}