import java.util.Arrays;

class Solution {
    public long maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length;
        int m = multipliers.length;

        // dp[i][j] represents the maximum score after performing 'i' operations,
        // having picked 'j' elements from the left side of 'nums'.
        // The remaining 'i - j' elements must have been picked from the right side.
        // The number of operations 'i' goes from 1 to m.
        // The number of elements from left 'j' goes from 0 to i.
        long[][] dp = new long[m + 1][m + 1];

        // Initialize dp table with a very small value to represent unreachable states.
        // This is important because scores can be negative.
        for (int i = 0; i <= m; i++) {
            Arrays.fill(dp[i], Long.MIN_VALUE);
        }

        // Base case: 0 operations, 0 elements picked from left, score is 0.
        dp[0][0] = 0;

        // Iterate through the number of operations (multipliers used)
        for (int i = 1; i <= m; i++) {
            int currentMultiplier = multipliers[i - 1]; // multipliers are 0-indexed

            // Iterate through the number of elements picked from the left
            // 'j' can range from 0 to 'i' (total operations)
            for (int j = 0; j <= i; j++) {
                long option1Score = Long.MIN_VALUE; // Score if we pick from left
                long option2Score = Long.MIN_VALUE; // Score if we pick from right

                // Option 1: Pick nums[j-1] (the j-th element from the left)
                // This means in the previous (i-1) operations, we picked (j-1) elements from the left.
                // Requires j > 0 (to pick an element from left) and dp[i-1][j-1] to be a valid previous state.
                if (j > 0 && dp[i - 1][j - 1] != Long.MIN_VALUE) {
                    option1Score = dp[i - 1][j - 1] + (long) nums[j - 1] * currentMultiplier;
                }

                // Option 2: Pick from the right side of nums.
                // If 'j' elements are picked from left, then 'i - j' elements are picked from right.
                // The index of the rightmost element to pick is n - (number of elements picked from right).
                // So, the index is n - (i - j).
                // This means in the previous (i-1) operations, we picked 'j' elements from the left.
                // Requires (i - j) > 0 (to pick an element from right) and dp[i-1][j] to be a valid previous state.
                if (j <= i - 1 && dp[i - 1][j] != Long.MIN_VALUE) {
                    int rightIdx = n - (i - j); // Index of the element to pick from the right
                    option2Score = dp[i - 1][j] + (long) nums[rightIdx] * currentMultiplier;
                }

                // Update dp[i][j] with the maximum of the two options
                dp[i][j] = Math.max(option1Score, option2Score);
            }
        }

        // The maximum score will be the maximum value in the last row of the dp table
        // (after 'm' operations).
        long maxScore = Long.MIN_VALUE;
        for (int j = 0; j <= m; j++) {
            maxScore = Math.max(maxScore, dp[m][j]);
        }

        return maxScore;
    }
}