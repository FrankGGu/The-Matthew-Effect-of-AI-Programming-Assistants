import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public long minCost(int[] nums, int k) {
        int n = nums.length;
        long[] dp = new long[n + 1];

        Arrays.fill(dp, Long.MAX_VALUE / 2); // Use Long.MAX_VALUE / 2 to prevent overflow during addition
        dp[0] = 0; // Base case: cost to split an empty prefix is 0

        // dp[i] will store the minimum cost to split nums[0...i-1]
        for (int i = 1; i <= n; i++) {
            Map<Integer, Integer> freq = new HashMap<>();
            int currentTrimmedMean = 0;

            // Iterate j from i-1 down to 0 to consider all possible last subarrays nums[j...i-1]
            // This allows efficient calculation of trimmed_mean for each subarray
            for (int j = i - 1; j >= 0; j--) {
                int num = nums[j];
                freq.put(num, freq.getOrDefault(num, 0) + 1);

                // Update currentTrimmedMean: it increments only when a number's frequency
                // first reaches 2, meaning it now appears at least twice.
                // If its frequency was already >= 2, it continues to be counted,
                // so no further increment is needed for this specific number.
                if (freq.get(num) == 2) {
                    currentTrimmedMean += 1;
                }

                // Calculate the cost of the current subarray nums[j...i-1]
                long currentSubarrayCost = (long) k + currentTrimmedMean;

                // Update dp[i] by considering splitting at index j
                // dp[j] is the minimum cost to split nums[0...j-1]
                // currentSubarrayCost is the cost of nums[j...i-1]
                dp[i] = Math.min(dp[i], dp[j] + currentSubarrayCost);
            }
        }

        return dp[n];
    }
}