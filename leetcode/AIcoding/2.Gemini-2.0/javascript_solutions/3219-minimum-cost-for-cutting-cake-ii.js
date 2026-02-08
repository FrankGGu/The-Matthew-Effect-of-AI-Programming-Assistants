var minCost = function(cuts, cakeLength) {
    cuts.push(0);
    cuts.push(cakeLength);
    cuts.sort((a, b) => a - b);

    const n = cuts.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let len = 2; len < n; len++) {
        for (let i = 0; i < n - len; i++) {
            let j = i + len;
            dp[i][j] = Infinity;
            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + cuts[j] - cuts[i]);
            }
        }
    }

    return dp[0][n - 1];
};