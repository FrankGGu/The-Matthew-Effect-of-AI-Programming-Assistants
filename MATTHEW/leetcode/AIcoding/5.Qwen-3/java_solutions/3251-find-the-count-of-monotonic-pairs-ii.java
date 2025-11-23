public class Solution {

import java.util.*;

public class Solution {
    public int countMonotonicPairs(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }
        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                dp[i][j] = dp[i][j - 1] + dp[i + 1][j];
                if (nums[i] <= nums[j]) {
                    dp[i][j] += dp[i + 1][j - 1];
                }
            }
        }
        return dp[0][n - 1];
    }
}
}