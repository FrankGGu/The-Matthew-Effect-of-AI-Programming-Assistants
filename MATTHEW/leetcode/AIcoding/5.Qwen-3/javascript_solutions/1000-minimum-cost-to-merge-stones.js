function mergeStones(stones) {
    const n = stones.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + stones[i];
    }

    const dp = new Array(n).fill(0).map(() => new Array(n).fill(0));
    const cost = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (let i = 0; i < n; ++i) {
        for (let j = i + 1; j < n; ++j) {
            cost[i][j] = cost[i][j - 1] + stones[j];
        }
    }

    for (let k = 2; k <= n; ++k) {
        for (let i = 0; i + k <= n; ++i) {
            let j = i + k - 1;
            dp[i][j] = Infinity;
            for (let m = i; m < j; ++m) {
                dp[i][j] = Math.min(dp[i][j], dp[i][m] + dp[m + 1][j]);
            }
            if ((j - i) % 2 === 0) {
                dp[i][j] = Math.min(dp[i][j], dp[i][j - 1] + cost[i][j]);
            }
        }
    }

    return dp[0][n - 1];
}