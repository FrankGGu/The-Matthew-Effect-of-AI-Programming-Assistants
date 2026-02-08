public class Solution {

import java.util.*;

public class Solution {
    public int minCost(String[] houses, int[] cost, int k) {
        int n = houses.length;
        int[][] dp = new int[k + 1][n];
        for (int i = 0; i <= k; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= k; i++) {
            for (int j = 0; j < n; j++) {
                int minCost = Integer.MAX_VALUE;
                for (int m = j; m >= 0; m--) {
                    if (m == 0) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][m]);
                    } else {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][m - 1] + getCost(houses, m, j, cost));
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            result = Math.min(result, dp[k][i]);
        }
        return result;
    }

    private int getCost(String[] houses, int start, int end, int[] cost) {
        int res = 0;
        for (int i = start; i <= end; i++) {
            if (i > start && !houses[i].equals(houses[i - 1])) {
                res += cost[i];
            }
        }
        return res;
    }
}
}