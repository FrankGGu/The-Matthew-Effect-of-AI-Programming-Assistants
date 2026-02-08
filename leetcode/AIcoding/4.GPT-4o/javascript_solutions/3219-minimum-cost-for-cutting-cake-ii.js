function minimumCost(n, cuts) {
    cuts.sort((a, b) => a - b);
    cuts.unshift(0);
    cuts.push(n);

    const dp = Array.from({ length: cuts.length }, () => Array(cuts.length).fill(0));

    for (let len = 2; len < cuts.length; len++) {
        for (let i = 0; i + len < cuts.length; i++) {
            const j = i + len;
            dp[i][j] = Infinity;
            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], cuts[j] - cuts[i] + dp[i][k] + dp[k][j]);
            }
        }
    }

    return dp[0][cuts.length - 1];
}