function maxEnergy(energy, k) {
    const n = energy.length;
    const m = energy[0].length;
    const dp = new Array(n).fill(0).map(() => new Array(m).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (i === 0 && j === 0) {
                dp[i][j] = energy[i][j];
            } else if (i === 0) {
                dp[i][j] = dp[i][j - 1] + energy[i][j];
            } else if (j === 0) {
                dp[i][j] = dp[i - 1][j] + energy[i][j];
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]) + energy[i][j];
            }
        }
    }

    return dp[n - 1][m - 1];
}