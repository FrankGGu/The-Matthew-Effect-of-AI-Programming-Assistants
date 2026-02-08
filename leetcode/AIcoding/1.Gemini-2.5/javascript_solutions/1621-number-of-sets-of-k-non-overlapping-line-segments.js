var numberOfSets = function(n, k) {
    const MOD = 10**9 + 7;

    // dp[i][j] will store the number of ways to choose j non-overlapping segments
    // from the first i points (labeled 0 to i-1).
    // The size of dp table will be (n + 1) x (k + 1).
    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));

    // S[i][j] will store the sum of dp[p][j] for p from 0 to i.
    // This is used to optimize the sum(dp[x][j-1] for x in 0 to i-2) part of the recurrence.
    const S = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));

    // Base case: 0 segments can be chosen in 1 way (by choosing nothing) from any number of points.
    for (let i = 0; i <= n; i++) {
        dp[i][0] = 1;
        // Update prefix sum for j=0
        S[i][0] = (i > 0 ? S[i-1][0] : 0) + dp[i][0];
        S[i][0] %= MOD;
    }

    // Fill the DP table
    // i represents the number of points considered (from 0 to i-1).
    // j represents the number of segments to choose.
    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            // Case 1: Point i-1 is not used as an endpoint for any segment.
            // In this case, we need to choose j segments from the first i-1 points (0 to i-2).
            let waysWithoutCurrentPoint = dp[i-1][j];

            // Case 2: Point i-1 is used as the right endpoint of the j-th segment.
            // Let this segment be [x, i-1], where x can be any point from 0 to i-2.
            // The previous j-1 segments must be chosen entirely from points 0 to x-1.
            // So, we need to sum dp[x][j-1] for x from 0 to i-2.
            // This sum is efficiently obtained from the prefix sum table: S[i-2][j-1].
            let waysWithCurrentPointAsEnd = (i >= 2 ? S[i-2][j-1] : 0);

            dp[i][j] = (waysWithoutCurrentPoint + waysWithCurrentPointAsEnd) % MOD;

            // Update the prefix sum table for the current (i, j)
            S[i][j] = (S[i-1][j] + dp[i][j]) % MOD;
        }
    }

    // The result is the number of ways to choose k segments from n points (0 to n-1).
    return dp[n][k];
};