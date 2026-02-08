var mergeStones = function(stones, k) {
    const n = stones.length;

    if ((n - 1) % (k - 1) !== 0) {
        return -1;
    }

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    const dp = Array(n).fill(0).map(() =>
        Array(n).fill(0).map(() =>
            Array(k + 1).fill(Infinity)
        )
    );

    for (let i = 0; i < n; i++) {
        dp[i][i][1] = 0;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;

            for (let m = 2; m <= k; m++) {
                for (let p = i; p < j; p++) {
                    if (dp[i][p][m - 1] !== Infinity && dp[p + 1][j][1] !== Infinity) {
                        dp[i][j][m] = Math.min(dp[i][j][m], dp[i][p][m - 1] + dp[p + 1][j][1]);
                    }
                }
            }

            if (len >= k && dp[i][j][k] !== Infinity) {
                dp[i][j][1] = dp[i][j][k] + (prefixSum[j + 1] - prefixSum[i]);
            }
        }
    }

    return dp[0][n - 1][1] === Infinity ? -1 : dp[0][n - 1][1];
};