class Solution {
    public int waysToReachTarget(int target, int[][] types) {
        int MOD = 1_000_000_007;

        // dp[j] will store the number of ways to earn exactly j points.
        // Initialize dp[0] to 1, as there's one way to earn 0 points (by not selecting any questions).
        long[] dp = new long[target + 1];
        dp[0] = 1;

        // Iterate through each type of question.
        for (int[] type : types) {
            int count = type[0]; // Number of questions of this type available
            int points = type[1]; // Points awarded for each question of this type

            // Iterate 'j' downwards from target to 'points'.
            // This order of iteration ensures that when we calculate dp[j],
            // dp[j - k * points] refers to the state where the current type's contributions
            // for points less than 'j' have already been considered.
            // This is the correct dynamic programming approach for bounded knapsack problems
            // when counting the number of ways.
            for (int j = target; j >= points; j--) {
                // For each possible number of questions 'k' of the current type (from 1 to 'count')
                for (int k = 1; k <= count; k++) {
                    // If using 'k' questions of this type (total 'k * points') does not exceed 'j'
                    if (j - k * points >= 0) {
                        // Add the ways to achieve 'j - k * points' to the current ways to achieve 'j'.
                        // dp[j - k * points] already includes ways using the current type for smaller points,
                        // effectively allowing us to use multiple questions of the current type.
                        dp[j] = (dp[j] + dp[j - k * points]) % MOD;
                    } else {
                        // If 'j - k * points' is negative, then using 'k' questions of this type
                        // would result in negative points. Since 'k' increases, any further 'k'
                        // values will also result in negative points. So, we can break from this inner loop.
                        break; 
                    }
                }
            }
        }

        return (int) dp[target];
    }
}