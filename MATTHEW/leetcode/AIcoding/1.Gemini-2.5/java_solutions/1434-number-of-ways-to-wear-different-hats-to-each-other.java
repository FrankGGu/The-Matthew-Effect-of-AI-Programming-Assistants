import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public int numberWays(List<List<Integer>> hats) {
        int n = hats.size();
        int MOD = 1_000_000_007;

        // Pre-process to get a list of people who like each hat
        // Max hat ID is 40. Array size 41 for 1-based indexing.
        List<Integer>[] hatToPeople = new List[41];
        for (int i = 0; i <= 40; i++) {
            hatToPeople[i] = new ArrayList<>();
        }

        for (int personId = 0; personId < n; personId++) {
            for (int hatId : hats.get(personId)) {
                hatToPeople[hatId].add(personId);
            }
        }

        // dp[mask] represents the number of ways to assign hats to people represented by 'mask'
        // using hats considered up to the current hatId.
        int[] dp = new int[1 << n];
        dp[0] = 1; // Base case: 1 way to assign no hats to no people (empty mask).

        // Iterate through each hat ID from 1 to 40
        for (int hatId = 1; hatId <= 40; hatId++) {
            // Create a new DP array for the current hatId.
            // Initialize with values from the previous DP array (dp).
            // This accounts for the case where the current hatId is NOT used.
            int[] next_dp = Arrays.copyOf(dp, dp.length);

            // For each person who likes the current hatId
            for (int personId : hatToPeople[hatId]) {
                // Iterate through all possible masks in reverse order.
                // This ensures that when we calculate next_dp[mask],
                // dp[mask ^ (1 << personId)] refers to the state *before*
                // personId potentially got hatId.
                for (int mask = (1 << n) - 1; mask >= 0; mask--) {
                    // If personId is in the current mask, it means we are trying to assign
                    // hatId to personId to form this 'mask'.
                    // The remaining people in 'mask ^ (1 << personId)' must have been
                    // assigned hats from previous hatIds.
                    if ((mask & (1 << personId)) != 0) { // Check if personId is in the current mask
                        int prevMask = mask ^ (1 << personId); // Mask without personId
                        next_dp[mask] = (next_dp[mask] + dp[prevMask]) % MOD;
                    }
                }
            }
            dp = next_dp; // Update dp for the next iteration (next hatId)
        }

        // The final answer is the number of ways to assign hats to all 'n' people,
        // which is represented by the mask (1 << n) - 1 (all bits set).
        return dp[(1 << n) - 1];
    }
}