var minCost = function(stones) {
    const n = stones.length;
    if (n === 0) return 0;
    if (n === 1) return 0;
    if (n === 2) return Math.abs(stones[1] - stones[0]);

    let dp = new Array(n).fill(0);
    dp[0] = 0;
    dp[1] = Math.abs(stones[1] - stones[0]);

    for (let i = 2; i < n; i++) {
        dp[i] = Math.min(
            dp[i - 1] + Math.abs(stones[i] - stones[i - 1]),
            dp[i - 2] + Math.abs(stones[i] - stones[i - 2])
        );
    }

    return dp[n - 1];
};