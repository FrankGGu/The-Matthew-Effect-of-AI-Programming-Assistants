public class Solution {

import java.util.*;

public class Solution {
    public int maxScore(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[k + 1][n];

        for (int i = 0; i < n; i++) {
            dp[0][i] = nums[i];
        }

        for (int step = 1; step <= k; step++) {
            for (int i = 0; i < n; i++) {
                int maxVal = 0;
                for (int j = 0; j < n; j++) {
                    if (Math.abs(i - j) <= step) {
                        maxVal = Math.max(maxVal, dp[step - 1][j]);
                    }
                }
                dp[step][i] = maxVal + nums[i];
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result = Math.max(result, dp[k][i]);
        }
        return result;
    }
}
}