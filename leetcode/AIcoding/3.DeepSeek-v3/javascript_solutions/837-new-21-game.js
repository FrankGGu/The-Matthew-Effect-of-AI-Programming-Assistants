var new21Game = function(N, K, W) {
    if (K === 0 || N >= K + W) return 1.0;
    let dp = new Array(N + 1).fill(0);
    dp[0] = 1.0;
    let windowSum = 1.0;
    let res = 0.0;
    for (let i = 1; i <= N; i++) {
        dp[i] = windowSum / W;
        if (i < K) {
            windowSum += dp[i];
        } else {
            res += dp[i];
        }
        if (i >= W) {
            windowSum -= dp[i - W];
        }
    }
    return res;
};