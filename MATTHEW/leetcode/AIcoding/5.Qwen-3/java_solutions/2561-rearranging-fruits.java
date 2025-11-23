public class Solution {

import java.util.*;

public class Solution {
    public int minCostToRearrangeBags(int[] fruits, int k) {
        int n = fruits.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                if (dp[i - 1][j] == Integer.MAX_VALUE) continue;
                for (int m = 0; m < i; m++) {
                    int cost = 0;
                    for (int l = m; l < i; l++) {
                        cost += Math.abs(fruits[l] - fruits[m]);
                    }
                    if (j + (i - m) <= k) {
                        dp[i][j + (i - m)] = Math.min(dp[i][j + (i - m)], dp[i - 1][j] + cost);
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j <= k; j++) {
            result = Math.min(result, dp[n][j]);
        }
        return result;
    }
}
}