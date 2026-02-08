function maxVolunteerCount(A, B) {
    let n = A.length;
    let m = B.length;
    let dp = Array(n + 1).fill(0).map(() => Array(m + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            if (A[i - 1] <= B[j - 1]) {
                dp[i][j] = Math.max(dp[i - 1][j - 1] + 1, dp[i][j - 1]);
            } else {
                dp[i][j] = dp[i][j - 1];
            }
        }
    }

    return dp[n][m];
}