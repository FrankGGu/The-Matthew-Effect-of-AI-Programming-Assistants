public class Solution {

import java.util.*;

public class Solution {
    public int maxProduct(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], -1);
        }
        dp[0][0] = 1;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                if (dp[i - 1][j] != -1) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j]);
                    if (j + nums[i - 1] <= k) {
                        dp[i][j + nums[i - 1]] = Math.max(dp[i][j + nums[i - 1]], dp[i - 1][j] * nums[i - 1]);
                    }
                }
            }
        }
        return dp[n][k];
    }
}
}