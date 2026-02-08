function minScoreTriangulation(p) {
    const n = p.length;
    const dp = Array.from({ length: n }, () => Array(n).fill(0));

    for (let k = 2; k < n; k++) {
        for (let i = 0; i + k < n; i++) {
            let j = i + k;
            dp[i][j] = Infinity;
            for (let m = i + 1; m < j; m++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][m] + dp[m][j] + p[i] * p[m] * p[j]);
            }
        }
    }

    return dp[0][n - 1];
}