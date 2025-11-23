var minDeletionSize = function(A) {
    const n = A.length;
    const m = A[0].length;
    const dp = new Array(m).fill(1);

    for (let j = 0; j < m; j++) {
        for (let i = j - 1; i >= 0; i--) {
            if (A[0][i] <= A[0][j]) {
                dp[j] = Math.max(dp[j], dp[i] + 1);
            }
        }
    }

    return m - Math.max(...dp);
};