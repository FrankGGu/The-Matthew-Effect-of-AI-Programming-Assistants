public class Solution {

import java.util.*;

public class Solution {
    public int minimizeMax(int[] nums, int x) {
        Arrays.sort(nums);
        int n = nums.length;
        int[][] dp = new int[n][x + 1];
        for (int i = 0; i <= x; i++) {
            dp[0][i] = Math.abs(nums[0] - nums[0]);
        }
        for (int i = 1; i < n; i++) {
            for (int j = 0; j <= x; j++) {
                if (j == 0) {
                    dp[i][j] = Math.min(dp[i - 1][j], Math.abs(nums[i] - nums[i - 1]));
                } else {
                    dp[i][j] = Math.min(dp[i - 1][j], Math.min(dp[i - 1][j - 1], Math.abs(nums[i] - nums[i - 1])));
                }
            }
        }
        return dp[n - 1][x];
    }
}
}