var minimumTotalDistance = function(robots, factories) {
    robots.sort((a, b) => a - b);
    factories.sort((a, b) => a[0] - b[0]);

    const n = robots.length;
    const m = factories.length;

    const dp = Array(n + 1).fill(null).map(() => Array(m + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 0; i <= n; i++) {
        for (let j = 0; j < m; j++) {
            if (dp[i][j] === Infinity) continue;

            dp[i][j + 1] = Math.min(dp[i][j + 1], dp[i][j]);

            let cost = 0;
            for (let k = 1; k <= Math.min(factories[j][1], n - i); k++) {
                cost += Math.abs(robots[i + k - 1] - factories[j][0]);
                dp[i + k][j + 1] = Math.min(dp[i + k][j + 1], dp[i][j] + cost);
            }
        }
    }

    return dp[n][m];
};