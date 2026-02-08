function maxProductPath(matrix) {
    const MOD = 1000000007;
    const m = matrix.length;
    const n = matrix[0].length;
    const dp = Array.from({ length: m }, () => Array.from({ length: n }, () => [0, 0]));

    dp[0][0][0] = matrix[0][0];
    dp[0][0][1] = matrix[0][0];

    for (let j = 1; j < n; j++) {
        dp[0][j][0] = dp[0][j - 1][0] * matrix[0][j];
        dp[0][j][1] = dp[0][j - 1][1] * matrix[0][j];
    }

    for (let i = 1; i < m; i++) {
        dp[i][0][0] = dp[i - 1][0][0] * matrix[i][0];
        dp[i][0][1] = dp[i - 1][0][1] * matrix[i][0];
    }

    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            const up = [dp[i - 1][j][0], dp[i - 1][j][1]];
            const left = [dp[i][j - 1][0], dp[i][j - 1][1]];
            let maxVal = Math.max(...up, ...left);
            let minVal = Math.min(...up, ...left);
            dp[i][j][0] = minVal * matrix[i][j];
            dp[i][j][1] = maxVal * matrix[i][j];
        }
    }

    return Math.max(dp[m - 1][n - 1][0], dp[m - 1][n - 1][1]) % MOD;
}