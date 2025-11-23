import java.util.Arrays;

class Solution {
    public int tallestBillboard(int[] rods) {
        int sum = 0;
        for (int rod : rods) {
            sum += rod;
        }

        // dp[diff + offset] stores the maximum sum of rods on the left side,
        // such that left_sum - right_sum = diff.
        // The maximum possible diff is 'sum', minimum is '-sum'.
        // So, we need an array of size 2 * sum + 1.
        // offset = sum to map diff from [-sum, sum] to [0, 2*sum].
        int offset = sum;
        int[] dp = new int[2 * sum + 1];
        Arrays.fill(dp, -1); // Initialize with -1 to indicate unreachable states
        dp[offset] = 0; // Base case: diff = 0, left_sum = 0 (and right_sum = 0)

        for (int rod : rods) {
            // Create a new dp array for the current rod to avoid using the rod multiple times
            // within the same iteration.
            // It's a copy of the dp state BEFORE considering the current rod.
            int[] new_dp = Arrays.copyOf(dp, dp.length);

            for (int d = 0; d < dp.length; d++) {
                if (dp[d] == -1) {
                    continue; // Skip unreachable states
                }

                // dp[d] represents current_left_sum, where (d - offset) is current_diff.

                // Option 1: Add rod to the left side
                // New diff index: d + rod
                // New left sum: dp[d] + rod
                if (d + rod < dp.length) { // Check bounds
                    new_dp[d + rod] = Math.max(new_dp[d + rod], dp[d] + rod);
                }

                // Option 2: Add rod to the right side
                // New diff index: d - rod
                // New left sum: dp[d] (left sum doesn't change, only right sum increases)
                if (d - rod >= 0) { // Check bounds
                    new_dp[d - rod] = Math.max(new_dp[d - rod], dp[d]);
                }
            }
            dp = new_dp; // Update dp for the next rod
        }

        // The answer is the maximum left_sum when diff is 0 (i.e., left_sum = right_sum)
        return dp[offset];
    }
}