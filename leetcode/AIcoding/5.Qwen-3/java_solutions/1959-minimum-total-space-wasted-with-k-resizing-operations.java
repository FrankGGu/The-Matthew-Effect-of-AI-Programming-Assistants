public class Solution {

import java.util.*;

public class Solution {
    public int minTotalSpaceWasted(int[] queries, int k) {
        int n = queries.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                int currentMax = 0;
                int total = 0;
                for (int m = i; m >= 1; m--) {
                    currentMax = Math.max(currentMax, queries[m - 1]);
                    total += queries[m - 1];
                    if (j >= 1 && dp[m - 1][j - 1] != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[m - 1][j - 1] + (currentMax * (i - m + 1) - total));
                    }
                }
            }
        }

        return dp[n][k];
    }
}
}