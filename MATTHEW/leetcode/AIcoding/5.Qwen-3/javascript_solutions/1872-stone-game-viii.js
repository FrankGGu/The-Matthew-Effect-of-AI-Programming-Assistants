function stoneGameVIII(stones) {
    const n = stones.length;
    for (let i = 1; i < n; i++) {
        stones[i] += stones[i - 1];
    }
    let dp = new Array(n).fill(0);
    dp[n - 1] = stones[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        dp[i] = Math.max(dp[i + 1], stones[i] - dp[i + 1]);
    }
    return dp[0];
}