public class Solution {

import java.util.*;

public class Solution {
    public int minimumTotalDistance(int[][] robot, int[][] factory) {
        Arrays.sort(robot, (a, b) -> a[0] - b[0]);
        Arrays.sort(factory, (a, b) -> a[0] - b[0]);

        int n = robot.length;
        int m = factory.length;

        int[][] dp = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        for (int i = 0; i < m; i++) {
            int[] f = factory[i];
            for (int j = 0; j < n; j++) {
                int cost = Math.abs(robot[j][0] - f[0]);
                if (i == 0) {
                    dp[i][j] = cost;
                } else {
                    for (int k = 0; k <= j; k++) {
                        if (dp[i - 1][k] != Integer.MAX_VALUE) {
                            dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + cost);
                        }
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int i = 0; i < m; i++) {
            result = Math.min(result, dp[i][n - 1]);
        }

        return result;
    }
}
}