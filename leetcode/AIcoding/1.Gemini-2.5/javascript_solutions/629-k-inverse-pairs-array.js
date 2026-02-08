var kInversePairs = function(n, k) {
    const MOD = 10**9 + 7;

    let dp = new Array(k + 1).fill(0);
    dp[0] = 1; // Base case: 0 elements, 0 inverse pairs, 1 way (empty array)

    for (let i = 1; i <= n; i++) {
        let newDp = new Array(k + 1).fill(0);
        newDp[0] = 1; // For 'i' elements, 0 inverse pairs, only 1 way (sorted array [1,2,...,i])

        for (let j = 1; j <= k; j++) {
            // Recurrence: dp[i][j] = dp[i][j-1] + dp[i-1][j] - dp[i-1][j-i]
            // newDp[j] represents dp[i][j]
            // newDp[j-1] represents dp[i][j-1]
            // dp[j] represents dp[i-1][j]
            newDp[j] = (newDp[j-1] + dp[j]) % MOD;

            // Subtract dp[i-1][j-i] if j-i is a valid index
            // dp[j-i] represents dp[i-1][j-i]
            if (j >= i) {
                newDp[j] = (newDp[j] - dp[j-i] + MOD) % MOD;
            }
        }
        dp = newDp; // Update dp to be the current row for the next iteration
    }

    return dp[k];
};