import java.util.Arrays;

public class Solution {
    public int minDifficulty(int[] jobDifficulty, int d) {
        int n = jobDifficulty.length;
        if (n < d) return -1;

        int[][] dp = new int[d + 1][n + 1];
        for (int[] row : dp) Arrays.fill(row, Integer.MAX_VALUE);
        dp[0][0] = 0;

        for (int day = 1; day <= d; day++) {
            for (int i = day; i <= n; i++) {
                int maxDifficulty = 0;
                for (int j = i; j >= day; j--) {
                    maxDifficulty = Math.max(maxDifficulty, jobDifficulty[j - 1]);
                    dp[day][i] = Math.min(dp[day][i], dp[day - 1][j - 1] + maxDifficulty);
                }
            }
        }

        return dp[d][n];
    }
}