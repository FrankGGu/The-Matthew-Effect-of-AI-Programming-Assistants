function maxEnergy(A, B) {
    const n = A.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = Math.max(dp[i - 1], dp[i - 1] + A[i - 1]);
        if (i > 1) {
            dp[i] = Math.max(dp[i], dp[i - 2] + B[i - 2]);
        }
    }

    return dp[n];
}