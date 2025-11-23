function stoneGameV(stones) {
    const n = stones.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + stones[i];
    }

    const dp = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (let length = 2; length <= n; ++length) {
        for (let i = 0; i + length - 1 < n; ++i) {
            let j = i + length - 1;
            let sum = prefix[j + 1] - prefix[i];
            let left = 0, right = 0;
            for (let k = i; k < j; ++k) {
                left = prefix[k + 1] - prefix[i];
                right = sum - left;
                if (left < right) {
                    dp[i][j] = Math.max(dp[i][j], dp[i][k] + left);
                } else if (left > right) {
                    dp[i][j] = Math.max(dp[i][j], dp[k + 1][j] + right);
                } else {
                    dp[i][j] = Math.max(dp[i][j], dp[i][k] + left, dp[k + 1][j] + right);
                }
            }
        }
    }

    return dp[0][n - 1];
}