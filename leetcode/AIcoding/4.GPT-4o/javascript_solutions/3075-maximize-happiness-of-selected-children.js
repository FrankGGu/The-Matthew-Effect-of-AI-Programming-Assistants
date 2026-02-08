function maxHappy(children, cookies, k) {
    const n = children.length;
    const dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j > 0) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + children[i - 1]);
            }
        }
    }

    return dp[n][k];
}