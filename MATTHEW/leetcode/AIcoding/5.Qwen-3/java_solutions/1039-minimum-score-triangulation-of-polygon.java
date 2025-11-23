public class Solution {

import java.util.*;

public class Solution {
    public int minScoreTriangulation(int[] values) {
        int n = values.length;
        int[][] dp = new int[n][n];

        for (int length = 2; length < n; length++) {
            for (int i = 0; i + length < n; i++) {
                int j = i + length;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    int score = dp[i][k] + dp[k][j] + values[i] * values[k] * values[j];
                    dp[i][j] = Math.min(dp[i][j], score);
                }
            }
        }

        return dp[0][n - 1];
    }
}
}