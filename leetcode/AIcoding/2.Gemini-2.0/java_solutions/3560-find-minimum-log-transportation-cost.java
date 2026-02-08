import java.util.*;

class Solution {
    public int minCost(int[] costs, int k) {
        int n = costs.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                for (int l = 0; l <= Math.min(i, j); l++) {
                    if (dp[i - l][j - l] != Integer.MAX_VALUE) {
                        int cost = 0;
                        for (int m = i - l; m < i; m++) {
                            cost += costs[m];
                        }
                        dp[i][j] = Math.min(dp[i][j], dp[i - l][j - l] + cost);
                    }
                }
            }
        }

        int ans = Integer.MAX_VALUE;
        for (int j = 0; j <= k; j++) {
            ans = Math.min(ans, dp[n][j]);
        }
        return ans;
    }
}