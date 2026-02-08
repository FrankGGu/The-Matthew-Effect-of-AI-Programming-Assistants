public class Solution {

import java.util.*;

public class Solution {
    public int minCostToCollectAllChocolates(int[] nums, int x) {
        int n = nums.length;
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            dp[i][i] = nums[i];
        }
        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                dp[i][j] = Math.min(dp[i + 1][j], dp[i][j - 1]) + nums[i] + nums[j];
            }
        }
        return dp[0][n - 1];
    }
}
}