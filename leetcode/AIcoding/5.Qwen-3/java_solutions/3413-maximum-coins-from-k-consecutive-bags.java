public class Solution {

import java.util.*;

public class Solution {
    public int maxCoins(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n][n];

        for (int length = 1; length <= n; length++) {
            for (int i = 0; i + length - 1 < n; i++) {
                int j = i + length - 1;
                int max = 0;
                for (int k = i; k <= j; k++) {
                    int left = (i == 0) ? 0 : nums[i - 1];
                    int right = (j == n - 1) ? 0 : nums[j + 1];
                    int current = nums[k] * left * right;
                    if (i < k) current += dp[i][k - 1];
                    if (k < j) current += dp[k + 1][j];
                    max = Math.max(max, current);
                }
                dp[i][j] = max;
            }
        }
        return dp[0][n - 1];
    }
}
}