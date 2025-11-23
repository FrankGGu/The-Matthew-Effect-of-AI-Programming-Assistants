import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minChanges(int[] nums, int k) {
        // The maximum possible value for nums[i] is 1000.
        // The maximum possible XOR sum for k numbers, each up to 1000,
        // will not exceed 2^10 - 1 = 1023.
        // So, we need to consider XOR sums from 0 to 1023.
        final int MAX_XOR_VAL = 1024;

        // dp[j] will store the minimum changes needed for the first 'i' groups
        // (columns) to have an XOR sum of 'j'.
        int[] dp = new int[MAX_XOR_VAL];
        // Initialize dp array with a very large value, representing infinity.
        // Using Integer.MAX_VALUE / 2 to prevent overflow when adding costs.
        Arrays.fill(dp, Integer.MAX_VALUE / 2);

        // Base case: for the first group (column 0)
        // Collect frequencies and count for elements in the first group.
        Map<Integer, Integer> freqMap0 = new HashMap<>();
        int count0 = 0;
        for (int i = 0; i < nums.length; i += k) {
            freqMap0.put(nums[i], freqMap0.getOrDefault(nums[i], 0) + 1);
            count0++;
        }

        // Initialize dp for the first group.
        // If we choose a target value 'x' for the first group, the cost is
        // (total elements in group) - (frequency of 'x' in group).
        // If 'x' is not present in the group, its frequency is 0, so cost is 'count0'.
        for (int j = 0; j < MAX_XOR_VAL; j++) {
            dp[j] = count0; // Default cost if 'j' is not present in freqMap0
        }
        for (Map.Entry<Integer, Integer> entry : freqMap0.entrySet()) {
            int val_x = entry.getKey();
            int freq_x = entry.getValue();
            dp[val_x] = Math.min(dp[val_x], count0 - freq_x);
        }

        // Iterate for subsequent groups (from 1 to k-1)
        for (int i = 1; i < k; i++) {
            // Collect frequencies and count for elements in the current group.
            Map<Integer, Integer> freqMap = new HashMap<>();
            int count = 0;
            for (int j = i; j < nums.length; j += k) {
                freqMap.put(nums[j], freqMap.getOrDefault(nums[j], 0) + 1);
                count++;
            }

            int[] new_dp = new int[MAX_XOR_VAL];
            Arrays.fill(new_dp, Integer.MAX_VALUE / 2);

            // Calculate the minimum cost from the previous DP state.
            // This is used for the case where we choose a target value 'x'
            // for the current group that is NOT present in its original elements.
            int min_prev_dp_val = Integer.MAX_VALUE / 2;
            for (int val : dp) {
                min_prev_dp_val = Math.min(min_prev_dp_val, val);
            }

            // Option 1: Choose a target value 'x' for the current group 'i' that is NOT in freqMap.
            // The cost for this group is 'count' (all elements must be changed).
            // The minimum total cost would be (min_prev_dp_val + count).
            // This applies to all possible final XOR sums 'j' for new_dp.
            for (int j = 0; j < MAX_XOR_VAL; j++) {
                new_dp[j] = min_prev_dp_val + count;
            }

            // Option 2: Choose a target value 'x' for the current group 'i' that IS in freqMap.
            // The cost for this group is 'count - freqMap[x]'.
            // Iterate over all possible values 'val_x' that the current group can take (from its original elements).
            for (Map.Entry<Integer, Integer> entry : freqMap.entrySet()) {
                int val_x = entry.getKey();
                int freq_x = entry.getValue();

                // For each possible previous XOR sum 'prev_xor' from the dp array:
                for (int prev_xor = 0; prev_xor < MAX_XOR_VAL; prev_xor++) {
                    // If dp[prev_xor] is infinity, it's not a reachable state, so skip.
                    if (dp[prev_xor] == Integer.MAX_VALUE / 2) {
                        continue;
                    }

                    // The current XOR sum will be 'prev_xor ^ val_x'.
                    int current_xor = prev_xor ^ val_x;

                    // Update new_dp[current_xor] with the minimum cost to reach this state.
                    new_dp[current_xor] = Math.min(new_dp[current_xor], dp[prev_xor] + count - freq_x);
                }
            }
            dp = new_dp; // Update dp for the next iteration
        }

        // After iterating through all 'k' groups, dp[0] will contain the minimum changes
        // required to make the final XOR sum of all groups equal to 0.
        return dp[0];
    }
}