class Solution {
    public int numWays(int steps, int arrLen) {
        final int MOD = 1_000_000_007;

        // The maximum position we can reach and still return to index 0
        // within 'steps' steps is steps / 2.
        // For example, if steps = 4, max position to reach and return is 2 (R-R-L-L).
        // If we go to position 3, we need 3 steps to return, but only 1 step left (R-R-R-?)
        // Also, we cannot go beyond arrLen - 1.
        // So, the maximum index we need to consider in our DP array is
        // min(arrLen - 1, steps / 2).
        // Adding 1 to maxPosition to define the array size (0 to maxPosition inclusive).
        int maxPosition = Math.min(arrLen - 1, steps / 2);

        // dp[j] represents the number of ways to be at index j after the current step.
        // We use two arrays (current and next) for space optimization.
        int[] dp = new int[maxPosition + 1];

        // Base case: after 0 steps, there is 1 way to be at index 0.
        dp[0] = 1;

        // Iterate through each step from 1 to 'steps'
        for (int s = 1; s <= steps; s++) {
            int[] next_dp = new int[maxPosition + 1];

            // For step 's', the maximum index we can reach is 's'.
            // However, we only need to consider indices up to 'maxPosition'
            // (which is min(arrLen - 1, steps / 2)).
            // So, the effective upper bound for 'j' in this step is min(s, maxPosition).
            int currentMaxJ = Math.min(s, maxPosition);

            // Iterate through each possible position 'j'
            for (int j = 0; j <= currentMaxJ; j++) {
                // Option 1: Stay at current position j
                next_dp[j] = dp[j];

                // Option 2: Move right from position j-1
                if (j > 0) {
                    next_dp[j] = (next_dp[j] + dp[j - 1]) % MOD;
                }

                // Option 3: Move left from position j+1
                // We need to ensure j+1 is within the bounds of maxPosition
                if (j < maxPosition) {
                    next_dp[j] = (next_dp[j] + dp[j + 1]) % MOD;
                }
            }
            dp = next_dp;
        }

        // After 'steps' steps, return the number of ways to be at index 0.
        return dp[0];
    }
}