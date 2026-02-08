var numOfArrays = function(n, m, k) {
    const MOD = 10**9 + 7;

    // dp[i][j][c] = number of ways to build an array of length i,
    // where the maximum element is j, and exactly c comparisons were made.
    const dp = Array(n + 1).fill(0).map(() =>
        Array(m + 1).fill(0).map(() =>
            Array(k + 1).fill(0)
        )
    );

    // prefix_sum_dp[i][c][j] = sum(dp[i][p][c]) for 1 <= p <= j.
    // This is used to efficiently calculate the sum for the "new maximum" case.
    const prefix_sum_dp = Array(n + 1).fill(0).map(() =>
        Array(k + 1).fill(0).map(() =>
            Array(m + 1).fill(0)
        )
    );

    // Base case: For arrays of length 1, the max element is j, and 1 comparison is made.
    for (let j = 1; j <= m; j++) {
        dp[1][j][1] = 1;
    }

    // Initialize prefix_sum_dp for length 1.
    // Only c=1 will have non-zero values for i=1.
    for (let j = 1; j <= m; j++) {
        prefix_sum_dp[1][1][j] = (prefix_sum_dp[1][1][j-1] + dp[1][j][1]) % MOD;
    }

    // Fill DP table for lengths from 2 to n
    for (let i = 2; i <= n; i++) {
        for (let c = 1; c <= k; c++) {
            for (let j = 1; j <= m; j++) {
                // Case 1: The i-th element is j, and j is a new maximum.
                // This means the previous i-1 elements had a maximum p < j, and c-1 comparisons.
                // The number of ways is sum(dp[i-1][p][c-1]) for 1 <= p < j.
                // This sum is prefix_sum_dp[i-1][c-1][j-1].
                // If c-1 is 0 or j-1 is 0, prefix_sum_dp will be 0, which is correct.
                dp[i][j][c] = (dp[i][j][c] + prefix_sum_dp[i-1][c-1][j-1]) % MOD;

                // Case 2: The i-th element is x (1 <= x <= j), and j was already the maximum.
                // This means the previous i-1 elements had maximum j, and c comparisons.
                // There are j choices for x (from 1 to j).
                dp[i][j][c] = (dp[i][j][c] + dp[i-1][j][c] * j) % MOD;
            }

            // After calculating all dp[i][j][c] for current i and c, compute prefix_sum_dp[i][c][j].
            for (let j = 1; j <= m; j++) {
                prefix_sum_dp[i][c][j] = (prefix_sum_dp[i][c][j-1] + dp[i][j][c]) % MOD;
            }
        }
    }

    // The final answer is the sum of dp[n][j][k] for all possible maximums j (1 to m).
    // This sum is conveniently stored in prefix_sum_dp[n][k][m].
    return prefix_sum_dp[n][k][m];
};