var longestArithSeqLength = function(A) {
    const n = A.length;
    const dp = Array.from({ length: n }, () => ({}));
    let maxLength = 2;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const diff = A[i] - A[j];
            if (dp[j][diff]) {
                dp[i][diff] = dp[j][diff] + 1;
            } else {
                dp[i][diff] = 2;
            }
            maxLength = Math.max(maxLength, dp[i][diff]);
        }
    }

    return maxLength;
};