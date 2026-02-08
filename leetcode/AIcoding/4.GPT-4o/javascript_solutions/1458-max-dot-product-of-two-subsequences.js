var maxDotProduct = function(A, B) {
    const m = A.length, n = B.length;
    const dp = Array.from({ length: m + 1 }, () => Array(n + 1).fill(-Infinity));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1] + A[i - 1] * B[j - 1]);
        }
    }

    return dp[m][n];
};