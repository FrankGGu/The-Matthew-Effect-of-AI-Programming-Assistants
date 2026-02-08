class Solution {
    public int numberOfSets(int n, int k) {
        long[][] dp = new long[n + 1][k + 1];
        int MOD = 1_000_000_007;

        // Base case: 0 segments can be chosen in 1 way (by choosing no segments)
        // from any number of points.
        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1;
        }

        // dp[i][j] represents the number of ways to choose 'j' non-overlapping line segments
        // using 'i' points (labeled from 0 to i-1).

        // The recurrence relation is derived from:
        // dp[i][j] = dp[i-1][j] + sum_{p=1 to i-1} dp[p][j-1]
        // where the sum considers making the j-th segment end at point (i-1),
        // and the previous j-1 segments are chosen from points 0 to p-1,
        // with p being the start point of the j-th segment.
        //
        // This sum can be optimized using prefix sums, leading to the recurrence:
        // dp[i][j] = (2 * dp[i-1][j] - dp[i-2][j] + dp[i-1][j-1]) % MOD
        // This optimized recurrence is valid for i >= 2 and j >= 1.

        for (int i = 1; i <= n; i++) { // Iterate through the number of points available (from 1 to n)
            for (int j = 1; j <= k; j++) { // Iterate through the number of segments to choose (from 1 to k)
                // If the number of points 'i' is less than twice the number of segments 'j',
                // it's impossible to form 'j' segments, as each segment requires at least 2 distinct points.
                if (i < 2 * j) {
                    dp[i][j] = 0; // The default value is 0, but explicit for clarity
                    continue;
                }

                // For i = 1, the recurrence dp[i-2][j] would access dp[-1][j], which is invalid.
                // However, for i = 1 and j >= 1, the condition `i < 2 * j` (1 < 2*j) will always be true,
                // causing `dp[1][j]` to be set to 0. This correctly handles the base case for i=1.
                // Thus, the optimized recurrence is only executed for i >= 2.

                // Apply the optimized recurrence relation.
                // Ensure results stay positive with modulo arithmetic by adding MOD before taking modulo
                // in case of negative intermediate results from subtraction.
                long val = (2 * dp[i-1][j]) % MOD;
                val = (val - dp[i-2][j] + MOD) % MOD; 
                val = (val + dp[i-1][j-1]) % MOD;

                dp[i][j] = val;
            }
        }

        return (int) dp[n][k];
    }
}