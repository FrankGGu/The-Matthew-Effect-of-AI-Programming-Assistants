public class Solution {

import java.util.*;

public class Solution {
    public int minCostToMakeGoodCaption(String s, String[] words) {
        int n = s.length();
        int m = words.length;
        int[][] dp = new int[n + 1][n + 1];

        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= i; j++) {
                if (dp[i][j] == Integer.MAX_VALUE) continue;

                for (int k = i + 1; k <= n; k++) {
                    String sub = s.substring(i, k);
                    int cost = 0;

                    for (String word : words) {
                        if (sub.contains(word)) {
                            cost += 1;
                        }
                    }

                    if (dp[k][k - j] > dp[i][j] + cost) {
                        dp[k][k - j] = dp[i][j] + cost;
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j <= n; j++) {
            result = Math.min(result, dp[n][j]);
        }

        return result;
    }
}
}