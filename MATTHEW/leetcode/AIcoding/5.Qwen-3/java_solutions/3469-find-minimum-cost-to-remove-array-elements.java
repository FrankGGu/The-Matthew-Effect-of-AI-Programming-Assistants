public class Solution {

import java.util.*;

public class Solution {
    public int minCostToRemoveArrays(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n][n];

        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
            dp[i][i] = 0;
        }

        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                for (int m = i; m <= j; m++) {
                    int cost = 0;
                    if (m > i) {
                        cost += dp[i][m - 1];
                    }
                    if (m < j) {
                        cost += dp[m + 1][j];
                    }
                    if (m > i && m < j) {
                        cost += Math.abs(nums[m] - nums[m - 1]) + Math.abs(nums[m] - nums[m + 1]);
                    } else if (m > i) {
                        cost += Math.abs(nums[m] - nums[m - 1]);
                    } else if (m < j) {
                        cost += Math.abs(nums[m] - nums[m + 1]);
                    }
                    dp[i][j] = Math.min(dp[i][j], cost);
                }
            }
        }

        return dp[0][n - 1];
    }
}
}