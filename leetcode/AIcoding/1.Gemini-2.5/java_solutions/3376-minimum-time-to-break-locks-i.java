class Solution {
    public long minCost(int[] strength) {
        int n = strength.length;
        if (n == 0) {
            return 0;
        }

        // dp[i] will store the minimum cost to break the first i locks (from index 0 to i-1).
        // Using long to prevent potential overflow, as costs can accumulate to large values.
        long[] dp = new long[n + 1];

        // Base case: 0 locks require 0 cost.
        dp[0] = 0;

        // Iterate for each number of locks from 1 to n.
        for (int i = 1; i <= n; i++) {
            dp[i] = Long.MAX_VALUE; // Initialize with a very large value.

            long currentMaxStrength = 0;
            // Consider all possible last segments ending at lock i-1.
            // The segment starts at index j and ends at index i-1.
            // j goes from i-1 down to 0.
            for (int j = i - 1; j >= 0; j--) {
                // Update currentMaxStrength for the segment [j, i-1].
                // strength[j] is the current lock being considered as part of the segment.
                currentMaxStrength = Math.max(currentMaxStrength, strength[j]);

                // The cost to break locks up to i-1, with [j, i-1] being the last segment broken,
                // is dp[j] (cost to break locks up to j-1) + currentMaxStrength (cost for segment [j, i-1]).
                // We check if dp[j] is reachable (not Long.MAX_VALUE) to prevent overflow
                // if Long.MAX_VALUE is added to a positive number, resulting in a negative value.
                // This check is generally good practice, though for this problem with non-negative strengths,
                // dp[j] will always be a valid, non-MAX_VALUE number if j is a valid state (0 to i-1).
                if (dp[j] != Long.MAX_VALUE) {
                    dp[i] = Math.min(dp[i], dp[j] + currentMaxStrength);
                }
            }
        }

        return dp[n];
    }
}