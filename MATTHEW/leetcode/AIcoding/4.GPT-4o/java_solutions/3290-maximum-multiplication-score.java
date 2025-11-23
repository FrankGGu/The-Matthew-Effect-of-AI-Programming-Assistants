import java.util.*;

class Solution {
    public int maximumMultiplicationScore(int[] nums, int multipliers) {
        int n = nums.length;
        int m = multipliers;
        long[][] dp = new long[m + 1][m + 1];
        for (int i = 0; i <= m; i++) {
            Arrays.fill(dp[i], Long.MIN_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j <= i; j++) {
                if (dp[i][j] == Long.MIN_VALUE) continue;
                dp[i + 1][j] = Math.max(dp[i + 1][j], dp[i][j] + nums[j] * multipliers[i]);
                dp[i + 1][j + 1] = Math.max(dp[i + 1][j + 1], dp[i][j] + nums[n - 1 - (i - j)] * multipliers[i]);
            }
        }

        long maxScore = Long.MIN_VALUE;
        for (int j = 0; j <= m; j++) {
            maxScore = Math.max(maxScore, dp[m][j]);
        }

        return (int) maxScore;
    }
}