var new21Game = function(N, K, W) {
    if (K === 0 || N >= K) return 1.0;
    let dp = new Array(N + 1).fill(0);
    dp[0] = 1;
    let wSum = dp[0];

    for (let i = 1; i <= N; i++) {
        dp[i] = wSum / W;
        if (i < K) wSum += dp[i];
        if (i >= W) wSum -= dp[i - W];
    }

    let result = 0;
    for (let i = K; i <= N; i++) {
        result += dp[i];
    }

    return result;
};