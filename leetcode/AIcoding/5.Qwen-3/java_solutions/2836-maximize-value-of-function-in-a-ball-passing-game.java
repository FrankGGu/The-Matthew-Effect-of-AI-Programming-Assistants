public class Solution {

import java.util.*;

public class Solution {
    public int maxValueOfFunction(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[n][k + 1];
        for (int i = 0; i < n; i++) {
            dp[i][0] = nums[i];
        }

        for (int step = 1; step <= k; step++) {
            for (int i = 0; i < n; i++) {
                int j = (i + step) % n;
                dp[i][step] = Math.max(dp[i][step - 1], dp[j][step - 1]);
            }
        }

        int maxVal = Integer.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            maxVal = Math.max(maxVal, dp[i][k]);
        }
        return maxVal;
    }
}
}