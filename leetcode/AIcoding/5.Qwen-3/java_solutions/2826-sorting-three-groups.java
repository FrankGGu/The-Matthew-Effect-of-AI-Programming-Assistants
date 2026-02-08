public class Solution {

import java.util.*;

public class Solution {
    public int minimumOperations(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[j] <= nums[i]) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
            dp[i] = Math.min(dp[i], 1);
        }

        return dp[n - 1];
    }
}
}