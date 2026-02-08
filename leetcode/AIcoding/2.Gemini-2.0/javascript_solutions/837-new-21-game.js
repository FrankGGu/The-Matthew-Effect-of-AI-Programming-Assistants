var new21Game = function(n, k, maxPts) {
    if (k === 0) {
        return 1.0;
    }
    if (n >= k + maxPts - 1) {
        return 1.0;
    }
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    let sum = 1;
    let ans = 0;
    for (let i = 1; i <= n; i++) {
        dp[i] = sum / maxPts;
        if (i < k) {
            sum += dp[i];
        } else {
            ans += dp[i];
        }
        if (i - maxPts >= 0) {
            sum -= dp[i - maxPts];
        }
    }
    return ans;
};