public class Solution {

import java.util.*;

public class Solution {
    public int minCostToDivideArray(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i < n; i++) {
            Set<Integer> unique = new HashSet<>();
            int max = 0;
            for (int j = i; j >= 0 && j >= i - k + 1; j--) {
                unique.add(nums[j]);
                max = Math.max(max, unique.size());
                if (j > 0) {
                    dp[i] = Math.min(dp[i], dp[j - 1] + max);
                } else {
                    dp[i] = Math.min(dp[i], max);
                }
            }
        }

        return dp[n - 1];
    }
}
}