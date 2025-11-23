import java.util.Arrays;

class Solution {
    public int minCost(int[] nums, int k) {
        int n = nums.length;
        long[] dp = new long[n + 1];
        Arrays.fill(dp, Long.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            int currentTrimmedCost = 0;
            int[] freq = new int[100001]; // Constraints: 0 <= nums[i] <= 10^5, so values up to 100000.

            for (int j = i - 1; j >= 0; j--) {
                // Current subarray is nums[j...i-1]
                int val = nums[j];

                // Update currentTrimmedCost based on the frequency of val in nums[j+1...i-1]
                // and then adding nums[j].
                if (freq[val] == 1) {
                    // val was unique (appeared once), now it appears twice.
                    // Its contribution to trimmed_cost changes from 0 to 2. Increase by 2.
                    currentTrimmedCost += 2;
                } else if (freq[val] > 1) {
                    // val already appeared more than once. Its count increases by 1.
                    // Its contribution to trimmed_cost increases by 1.
                    currentTrimmedCost += 1;
                }
                // If freq[val] == 0, it's the first occurrence of val in this subarray.
                // Its contribution to trimmed_cost is still 0. No change needed.

                freq[val]++; // Increment frequency for val in the current subarray nums[j...i-1]

                // Calculate the cost for the subarray nums[j...i-1]
                long costSubarray = (long)k + currentTrimmedCost;

                // Update dp[i]
                dp[i] = Math.min(dp[i], dp[j] + costSubarray);
            }
        }

        return (int) dp[n];
    }
}