var stoneGameVIII = function(stones) {
    const n = stones.length;
    const prefix = new Array(n).fill(0);
    prefix[0] = stones[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + stones[i];
    }
    let dp = new Array(n).fill(0);
    dp[n - 1] = prefix[n - 1];
    for (let i = n - 2; i >= 1; i--) {
        dp[i] = Math.max(dp[i + 1], prefix[i] - dp[i + 1]);
    }
    return dp[1];
};