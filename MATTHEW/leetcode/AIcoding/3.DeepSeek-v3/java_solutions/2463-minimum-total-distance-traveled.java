import java.util.Arrays;
import java.util.List;

class Solution {
    public long minimumTotalDistance(List<Integer> robot, int[][] factory) {
        Collections.sort(robot);
        Arrays.sort(factory, (a, b) -> a[0] - b[0]);
        int m = robot.size();
        int n = factory.length;
        long[][] dp = new long[n + 1][m + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Long.MAX_VALUE / 2);
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; i++) {
            int pos = factory[i - 1][0];
            int limit = factory[i - 1][1];
            dp[i][0] = 0;
            for (int j = 1; j <= m; j++) {
                long cost = 0;
                dp[i][j] = dp[i - 1][j];
                for (int k = 1; k <= Math.min(limit, j); k++) {
                    cost += Math.abs(pos - robot.get(j - k));
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - k] + cost);
                }
            }
        }
        return dp[n][m];
    }
}