public class Solution {

import java.util.*;

public class Solution {
    public int mctBlue(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n][n];

        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
            dp[i][i] = 0;
        }

        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                for (int k = i; k < j; k++) {
                    int left = dp[i][k];
                    int right = dp[k + 1][j];
                    int root = Math.max(nums[i], nums[j]);
                    dp[i][j] = Math.min(dp[i][j], left + right + root);
                }
            }
        }

        return dp[0][n - 1];
    }
}
}