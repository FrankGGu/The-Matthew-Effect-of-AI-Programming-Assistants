var numberOfArithmeticSlices = function(A) {
    const n = A.length;
    const dp = Array.from({ length: n }, () => ({}));
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const diff = A[i] - A[j];
            if (dp[j][diff] !== undefined) {
                dp[i][diff] = (dp[i][diff] || 0) + dp[j][diff];
                count += dp[j][diff];
            }
            dp[i][diff] = (dp[i][diff] || 0) + 1;
        }
    }

    return count;
};