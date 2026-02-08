import java.util.*;

class Solution {
    public int maxPizzaSlices(int[] slices) {
        int n = slices.length;
        int k = n / 3;
        int[][] dp = new int[k + 1][n + 1];

        for (int i = 1; i <= k; i++) {
            for (int j = 1; j <= n; j++) {
                dp[i][j] = Math.max(dp[i][j - 1], (j >= 2 ? dp[i - 1][j - 2] : 0) + slices[j - 1]);
            }
        }

        return dp[k][n];
    }
}