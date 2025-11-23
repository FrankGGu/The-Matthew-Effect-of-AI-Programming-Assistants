var supplyWagon = function(supply) {
    const m = supply.length;
    const n = supply[0].length;

    const dp = new Array(n);

    dp[0] = supply[0][0];
    for (let j = 1; j < n; j++) {
        dp[j] = supply[0][j] + dp[j - 1];
    }

    for (let i = 1; i < m; i++) {
        dp[0] = supply[i][0] + dp[0];

        for (let j = 1; j < n; j++) {
            dp[j] = supply[i][j] + Math.max(dp[j], dp[j - 1]);
        }
    }

    return dp[n - 1];
};