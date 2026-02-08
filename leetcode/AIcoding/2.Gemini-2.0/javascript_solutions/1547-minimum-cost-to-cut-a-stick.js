var minCost = function(n, cuts) {
    cuts.push(0);
    cuts.push(n);
    cuts.sort((a, b) => a - b);

    const m = cuts.length;
    const dp = Array(m).fill(null).map(() => Array(m).fill(0));

    for (let len = 2; len < m; len++) {
        for (let i = 0; i < m - len; i++) {
            let j = i + len;
            dp[i][j] = Infinity;
            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + cuts[j] - cuts[i]);
            }
        }
    }

    return dp[0][m - 1];
};