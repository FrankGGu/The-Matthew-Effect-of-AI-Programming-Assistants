class Solution {
    public int dieSimulator(int n, int[] rollMax) {
        final int MOD = 1_000_000_007;

        // dp[i][j] represents the number of sequences of length i ending with face j.
        // Faces are 0-indexed (0 to 5).
        long[][] dp = new long[n + 1][6];

        // totalWays[i] represents the total number of valid sequences of length i.
        long[] totalWays = new long[n + 1];

        // Base case for length 0:
        // An empty sequence is considered a valid starting point for appending the first die roll.
        // There is 1 way to have an empty sequence.
        totalWays[0] = 1; 
        // dp[0][j] remains 0, as an empty sequence doesn't end with any specific face.

        // Fill DP table for lengths from 1 to n
        for (int i = 1; i <= n; i++) {
            long currentTotal = 0;
            for (int j = 0; j < 6; j++) {
                // Initially, assume we can append face j to any valid sequence of length i-1.
                // This gives totalWays[i-1] sequences of length i ending with j.
                dp[i][j] = totalWays[i - 1];

                // Now, subtract invalid sequences due to rollMax[j] constraint.
                // An invalid sequence ending with j means j has appeared rollMax[j] + 1 times consecutively.
                // Such a sequence looks like: [Prefix] + [k] + [j, j, ..., j] (rollMax[j] + 1 times)
                // where k is any face different from j.
                // The length of [Prefix] + [k] is i - (rollMax[j] + 1).
                // The number of valid sequences of length `i - (rollMax[j] + 1)` that do NOT end with `j` is:
                // `totalWays[i - (rollMax[j] + 1)] - dp[i - (rollMax[j] + 1)][j]`

                // Check if we have enough previous rolls to violate the constraint.
                if (i - (rollMax[j] + 1) >= 0) {
                    long prevTotal = totalWays[i - (rollMax[j] + 1)];
                    long prevDPj = dp[i - (rollMax[j] + 1)][j];

                    long toSubtract = (prevTotal - prevDPj + MOD) % MOD;
                    dp[i][j] = (dp[i][j] - toSubtract + MOD) % MOD;
                }

                currentTotal = (currentTotal + dp[i][j]) % MOD;
            }
            totalWays[i] = currentTotal;
        }

        return (int) totalWays[n];
    }
}