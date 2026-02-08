import java.util.Arrays;

class Solution {
    public int maxTotalReward(int[] reward) {
        // Sort the reward array in ascending order.
        // This sorting is crucial for the dynamic programming approach to correctly
        // explore all possible reward combinations under the given condition (r > s).
        // Processing smaller rewards first allows for the accumulation of smaller sums 's',
        // which in turn enables larger rewards 'r' to satisfy the 'r > s' condition
        // and contribute to the total.
        Arrays.sort(reward);

        // The maximum possible value for any reward[i] is 1000.
        // Let R_max be the maximum value in the reward array (which is at most 1000).
        // If 'x' is the current total reward and we add 'r' (where r > x),
        // the new total is x' = x + r.
        // Since 'r' must be from the input array, r <= R_max.
        // Thus, x' = x + r <= x + R_max.
        // If 'x' itself becomes >= R_max, then no 'r' in the array can satisfy 'r > x'
        // because all 'r' are <= R_max.
        // This implies that the final total reward 'x_final' must have been formed
        // by adding some 'r_k' to 'x_{k-1}' where 'x_{k-1} < r_k'.
        // Since 'r_k <= R_max', it must be that 'x_{k-1} < R_max'.
        // Therefore, 'x_final = x_{k-1} + r_k < R_max + R_max = 2 * R_max'.
        // So, the maximum possible total reward is strictly less than 2 * R_max.
        // Given R_max <= 1000, the maximum total reward is less than 2000.
        // We can use a boolean array of size 2000 to store reachable sums (indices 0 to 1999).
        boolean[] dp = new boolean[2 * 1000]; // dp[s] is true if sum 's' is reachable.

        // Initial state: a total reward of 0 is reachable.
        dp[0] = true;

        // Iterate through each reward value.
        for (int r : reward) {
            // Iterate 's' (current total reward) downwards.
            // This ensures that when we compute dp[s + r], dp[s] refers to a sum
            // that does not include the current 'r', effectively using 'r' at most once.
            //
            // The loop for 's' has two conditions:
            // 1. 's + r' must be within the bounds of the dp array: s + r < dp.length => s < dp.length - r.
            //    So, 's' goes from `dp.length - 1 - r` downwards.
            // 2. The problem's condition: 'r > s'. So 's' must be less than 'r'.
            //    Thus, 's' goes from `r - 1` downwards.
            // Combining these, 's' iterates from `Math.min(dp.length - 1 - r, r - 1)` down to `0`.
            for (int s = Math.min(dp.length - 1 - r, r - 1); s >= 0; s--) {
                if (dp[s]) {
                    // If 's' is a reachable total reward and 'r > s',
                    // then 's + r' is also a reachable total reward.
                    dp[s + r] = true;
                }
            }
        }

        // After processing all rewards, find the largest reachable sum.
        int maxTotalReward = 0;
        for (int s = dp.length - 1; s >= 0; s--) {
            if (dp[s]) {
                maxTotalReward = s;
                break; // Found the largest reachable sum, no need to check smaller ones.
            }
        }

        return maxTotalReward;
    }
}