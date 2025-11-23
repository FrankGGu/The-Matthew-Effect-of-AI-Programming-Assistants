var checkRecord = function(n) {
    const MOD = 1000000007;

    // dp[absent_count][late_streak]
    // absent_count: 0 or 1
    // late_streak: 0 (ends with P or A), 1 (ends with L), 2 (ends with LL)

    // prev_dp represents dp[i-1]
    // Initialize for length 0: one way (empty string), 0 'A's, 0 'L' streak
    let prev_dp = [
        [0, 0, 0], // 0 'A's: [P/A, L, LL]
        [0, 0, 0]  // 1 'A': [P/A, L, LL]
    ];
    prev_dp[0][0] = 1; // Base case: empty string, 0 A, 0 L streak

    for (let i = 1; i <= n; i++) {
        let curr_dp = [
            [0, 0, 0],
            [0, 0, 0]
        ];

        // Calculate states for 0 'A's
        // Add 'P': current streak becomes 0, absent count remains 0
        curr_dp[0][0] = (prev_dp[0][0] + prev_dp[0][1] + prev_dp[0][2]) % MOD;
        // Add 'L': current streak becomes 1, absent count remains 0
        curr_dp[0][1] = prev_dp[0][0] % MOD;
        // Add 'L' (second consecutive): current streak becomes 2, absent count remains 0
        curr_dp[0][2] = prev_dp[0][1] % MOD;

        // Calculate states for 1 'A'
        // Add 'P': current streak becomes 0, absent count remains 1
        curr_dp[1][0] = (prev_dp[1][0] + prev_dp[1][1] + prev_dp[1][2]) % MOD;
        // Add 'L': current streak becomes 1, absent count remains 1
        curr_dp[1][1] = prev_dp[1][0] % MOD;
        // Add 'L' (second consecutive): current streak becomes 2, absent count remains 1
        curr_dp[1][2] = prev_dp[1][1] % MOD;

        // Add 'A': current streak becomes 0, absent count becomes 1.
        // This can only come from states with 0 'A's in the previous step.
        let waysToAddA = (prev_dp[0][0] + prev_dp[0][1] + prev_dp[0][2]) % MOD;
        curr_dp[1][0] = (curr_dp[1][0] + waysToAddA) % MOD;

        prev_dp = curr_dp;
    }

    let totalWays = 0;
    for (let j = 0; j <= 1; j++) {
        for (let k = 0; k <= 2; k++) {
            totalWays = (totalWays + prev_dp[j][k]) % MOD;
        }
    }

    return totalWays;
};