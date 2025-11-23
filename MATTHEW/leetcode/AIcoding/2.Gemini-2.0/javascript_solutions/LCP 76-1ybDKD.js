var solve = function(n, m, k) {
    if (k > Math.ceil(n * m / 2)) {
        return 0;
    }

    const dp = Array(n + 1).fill(null).map(() => Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j] * (m - (j - (i - 1) * Math.floor(m / 2)));

            if (j >= Math.floor(m / 2) + (m % 2)) {
                dp[i][j] += dp[i - 1][j - (Math.floor(m / 2) + (m % 2))] * (i - 1);
            }
        }
    }

    let total = 1;
    for (let i = 1; i <= n; i++) {
        total *= m;
    }

    return dp[n][k] / total;
};