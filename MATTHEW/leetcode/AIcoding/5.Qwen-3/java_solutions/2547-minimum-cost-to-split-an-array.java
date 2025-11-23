public class Solution {

import java.util.*;

public class Solution {
    public int minCostToSplit(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);

        for (int i = 0; i < n; i++) {
            int cost = 0;
            int maxVal = nums[i];
            for (int j = i; j >= 0 && j >= i - k + 1; j--) {
                maxVal = Math.max(maxVal, nums[j]);
                if (j > 0) {
                    dp[i] = Math.min(dp[i], dp[j - 1] + cost);
                } else {
                    dp[i] = Math.min(dp[i], cost);
                }
                cost += maxVal;
            }
        }

        return dp[n - 1];
    }
}
}