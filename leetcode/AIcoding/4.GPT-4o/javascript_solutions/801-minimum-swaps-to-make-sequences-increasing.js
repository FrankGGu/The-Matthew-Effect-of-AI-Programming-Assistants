var minSwap = function(A, B) {
    const n = A.length;
    const dp = Array.from({ length: n }, () => [0, 0]);

    dp[0][0] = 0; // no swap
    dp[0][1] = 1; // swap

    for (let i = 1; i < n; i++) {
        dp[i][0] = dp[i][1] = Infinity;

        if (A[i] > A[i - 1] && B[i] > B[i - 1]) {
            dp[i][0] = dp[i - 0][0];
            dp[i][1] = dp[i - 0][1] + 1;
        }

        if (A[i] > B[i - 1] && B[i] > A[i - 1]) {
            dp[i][0] = Math.min(dp[i][0], dp[i - 1][1]);
            dp[i][1] = Math.min(dp[i][1], dp[i - 1][0] + 1);
        }
    }

    return Math.min(dp[n - 1][0], dp[n - 1][1]);
};