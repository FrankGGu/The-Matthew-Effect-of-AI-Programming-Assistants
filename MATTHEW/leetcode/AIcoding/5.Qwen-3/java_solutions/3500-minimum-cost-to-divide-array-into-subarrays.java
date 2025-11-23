public class Solution {

import java.util.*;

public class Solution {
    public int minCostToDivideArray(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i < n; i++) {
            int maxVal = nums[i];
            int minCost = Integer.MAX_VALUE;
            for (int j = i; j >= 0 && j >= i - k + 1; j--) {
                maxVal = Math.max(maxVal, nums[j]);
                if (j > 0) {
                    minCost = Math.min(minCost, dp[j - 1] + maxVal);
                } else {
                    minCost = Math.min(minCost, maxVal);
                }
            }
            dp[i] = minCost;
        }

        return dp[n - 1];
    }
}
}