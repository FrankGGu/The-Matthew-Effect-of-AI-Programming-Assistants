public class Solution {

import java.util.*;

public class Solution {
    public int maximumSum(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        int maxSum = 1;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            maxSum = Math.max(maxSum, dp[i]);
        }

        return maxSum;
    }
}
}