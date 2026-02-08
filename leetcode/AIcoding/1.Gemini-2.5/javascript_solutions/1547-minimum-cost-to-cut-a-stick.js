var minCost = function(n, cuts) {
    const augmentedCuts = [0, ...cuts, n];
    augmentedCuts.sort((a, b) => a - b);

    const m = augmentedCuts.length;
    const dp = Array(m).fill(0).map(() => Array(m).fill(0));

    for (let len = 2; len < m; len++) {
        for (let i = 0; i < m - len; i++) {
            const j = i + len;
            dp[i][j] = Infinity;

            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + (augmentedCuts[j] - augmentedCuts[i]));
            }
        }
    }

    return dp[0][m - 1];
};