function minTimeToBreakLocks(A) {
    let n = A.length;
    let dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= i; j++) {
            dp[i] = Math.min(dp[i], dp[i - j] + A[j - 1]);
        }
    }
    return dp[n];
}