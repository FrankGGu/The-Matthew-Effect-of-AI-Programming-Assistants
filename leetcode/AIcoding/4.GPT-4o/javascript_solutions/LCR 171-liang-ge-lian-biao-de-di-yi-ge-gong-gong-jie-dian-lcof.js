var canCompletePlan = function (A, B, C) {
    let n = A.length;
    let dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + A[i - 1];
        if (i >= C) {
            dp[i] = Math.max(dp[i], dp[i - C] + B[i - 1]);
        }
    }

    return dp[n] >= 0;
};