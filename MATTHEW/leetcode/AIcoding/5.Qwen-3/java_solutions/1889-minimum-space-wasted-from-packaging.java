public class Solution {

import java.util.*;

public class Solution {
    public int minSpaceWastedForPackaging(int[] nums, int[] weights) {
        int n = nums.length;
        int m = weights.length;
        int[][] dp = new int[n + 1][m + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                if (nums[i - 1] <= weights[j - 1]) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1] + (weights[j - 1] - nums[i - 1]));
                }
                dp[i][j] = Math.min(dp[i][j], dp[i][j - 1]);
            }
        }
        return dp[n][m];
    }
}
}