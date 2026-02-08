double new21Game(int N, int K, int W) {
    if (K == 0 || N >= K) return 1.0;
    double dp[W + 1] = {0};
    dp[0] = 1.0;
    double sum = 1.0, result = 0.0;

    for (int i = 1; i <= N; i++) {
        dp[i % (W + 1)] = sum / W;
        if (i < K) sum += dp[i % (W + 1)];
        if (i >= W) sum -= dp[(i - W) % (W + 1)];
        if (i >= K) result += dp[i % (W + 1)];
    }

    return result;
}