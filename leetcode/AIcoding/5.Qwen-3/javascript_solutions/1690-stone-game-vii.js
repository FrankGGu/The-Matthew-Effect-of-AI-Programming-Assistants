var stoneGameVII = function(stones) {
    let n = stones.length;
    let prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + stones[i];
    }

    let dp = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (let length = 2; length <= n; length++) {
        for (let i = 0; i + length - 1 < n; i++) {
            let j = i + length - 1;
            dp[i][j] = Math.max(stones[i] - stones[j] + dp[i + 1][j], stones[j] - stones[i] + dp[i][j - 1]);
        }
    }

    return dp[0][n - 1];
};