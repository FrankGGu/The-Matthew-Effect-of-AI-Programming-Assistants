var minCost = function(n, cuts) {
    cuts.sort((a, b) => a - b);
    cuts = [0, ...cuts, n];
    const m = cuts.length;
    const dp = Array.from({ length: m }, () => new Array(m).fill(0));

    for (let len = 2; len < m; len++) {
        for (let i = 0; i + len < m; i++) {
            const j = i + len;
            dp[i][j] = Infinity;
            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + cuts[j] - cuts[i]);
            }
        }
    }

    return dp[0][m - 1];
};