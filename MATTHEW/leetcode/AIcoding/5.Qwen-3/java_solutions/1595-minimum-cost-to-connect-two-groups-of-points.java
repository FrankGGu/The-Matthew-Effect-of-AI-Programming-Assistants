public class Solution {

import java.util.*;

public class Solution {
    public int minCostConnectTwoGroups(int[][] points) {
        int n = points.length;
        int m = points[0].length;
        int[][] dp = new int[n + 1][1 << m];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;
        for (int i = 0; i < n; i++) {
            for (int mask = 0; mask < (1 << m); mask++) {
                if (dp[i][mask] == Integer.MAX_VALUE) continue;
                for (int j = 0; j < m; j++) {
                    int newMask = mask | (1 << j);
                    dp[i + 1][newMask] = Math.min(dp[i + 1][newMask], dp[i][mask] + points[i][j]);
                }
            }
        }
        int result = Integer.MAX_VALUE;
        for (int mask = 0; mask < (1 << m); mask++) {
            int cost = dp[n][mask];
            for (int j = 0; j < m; j++) {
                if ((mask & (1 << j)) == 0) {
                    for (int i = 0; i < n; i++) {
                        cost = Math.min(cost, dp[i][mask] + points[i][j]);
                    }
                }
            }
            result = Math.min(result, cost);
        }
        return result;
    }
}
}