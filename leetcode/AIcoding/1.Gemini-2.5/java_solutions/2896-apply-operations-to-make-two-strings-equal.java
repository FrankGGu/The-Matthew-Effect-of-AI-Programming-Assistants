import java.util.ArrayList;
import java.util.List;

class Solution {
    public long minOperations(String s1, String s2, int x) {
        List<Integer> diffIndices = new ArrayList<>();
        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                diffIndices.add(i);
            }
        }

        int k = diffIndices.size();

        if (k == 0) {
            return 0;
        }

        // dp[i] represents the minimum cost to fix 'i' mismatches.
        // The actual indices of the mismatches do not affect the cost of operations,
        // as operation 1 (cost x) can be applied to any two mismatched indices,
        // and operation 2 (cost 1) can be applied to any single mismatched index.
        // Therefore, we only need to consider the count of mismatches.
        long[] dp = new long[k + 1];

        // Base case: 0 mismatches require 0 cost.
        dp[0] = 0;

        // Base case: 1 mismatch requires 1 operation of type 2 (cost 1).
        // It's impossible to use operation 1 (which requires 2 mismatches).
        if (k >= 1) {
            dp[1] = 1;
        }

        // Fill the DP table for i from 2 to k.
        // For 'i' mismatches, we have two options:
        // 1. Fix one mismatch using operation 2 (cost 1), then solve for the remaining i-1 mismatches.
        //    Total cost: dp[i-1] + 1.
        // 2. Fix two mismatches using operation 1 (cost x), then solve for the remaining i-2 mismatches.
        //    Total cost: dp[i-2] + x.
        // We take the minimum of these two options.
        for (int i = 2; i <= k; i++) {
            dp[i] = Math.min(dp[i - 1] + 1, dp[i - 2] + x);
        }

        return dp[k];
    }
}