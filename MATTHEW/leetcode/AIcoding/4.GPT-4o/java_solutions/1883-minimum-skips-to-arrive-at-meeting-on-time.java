import java.util.PriorityQueue;

public class Solution {
    public int minSkips(int[] dist, int speed, int hoursBefore) {
        int n = dist.length;
        double[][] dp = new double[n + 1][n + 1];
        for (double[] d : dp) {
            java.util.Arrays.fill(d, Double.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= i; j++) {
                if (dp[i][j] < Double.MAX_VALUE) {
                    double time = dp[i][j] + (double) dist[i] / speed;
                    dp[i + 1][j] = Math.min(dp[i + 1][j], Math.ceil(time));
                    if (j + 1 <= n) {
                        dp[i + 1][j + 1] = Math.min(dp[i + 1][j + 1], time);
                    }
                }
            }
        }

        for (int j = 0; j <= n; j++) {
            if (dp[n][j] <= hoursBefore) {
                return j;
            }
        }
        return n;
    }
}