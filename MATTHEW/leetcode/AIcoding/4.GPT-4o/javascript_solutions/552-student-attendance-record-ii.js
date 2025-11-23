var checkRecord = function(n) {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: n + 1 }, () => Array(3).fill(0));

    dp[0][0] = 1; // No absent and no late

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < 3; j++) {
            dp[i][0] = (dp[i][0] + dp[i - 1][j]) % MOD; // Present
            if (j > 0) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD; // Late
            }
        }
    }

    let total = 0;
    for (let j = 0; j < 3; j++) {
        total = (total + dp[n][j]) % MOD; // Total for all valid records
    }

    // Calculate the total valid records with up to 1 absent
    const result = (total + total - dp[n][1]) % MOD; // Subtract the case where there are 2 lates

    return result;
};