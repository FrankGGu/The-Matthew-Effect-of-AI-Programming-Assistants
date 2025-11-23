var minCost = function(n, cuts) {
    cuts.sort((a, b) => a - b);
    cuts.unshift(0);
    cuts.push(n);

    const dp = Array(cuts.length).fill(0).map(() => Array(cuts.length).fill(0));

    for (let len = 2; len < cuts.length; len++) {
        for (let i = 0; i + len < cuts.length; i++) {
            let j = i + len;
            dp[i][j] = Infinity;
            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + cuts[j] - cuts[i]);
            }
        }
    }

    return dp[0][cuts.length - 1];
};