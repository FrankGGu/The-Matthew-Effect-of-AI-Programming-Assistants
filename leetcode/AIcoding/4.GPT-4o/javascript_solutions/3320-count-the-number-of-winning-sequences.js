var countWinningSequences = function(A) {
    const n = A.length;
    let dp = new Array(n).fill(0);
    dp[0] = 1;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (A[j] > A[i]) {
                dp[j] = (dp[j] + dp[i]) % (1e9 + 7);
            }
        }
    }

    return dp.reduce((a, b) => (a + b) % (1e9 + 7), 0);
};