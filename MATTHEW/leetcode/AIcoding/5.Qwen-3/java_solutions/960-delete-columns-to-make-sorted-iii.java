public class Solution {

import java.util.*;

public class Solution {
    public int minDeletionSize(String[] grid, int k) {
        int n = grid.length;
        int m = grid[0].length();

        int[][] dp = new int[n][k + 1];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], 1);
        }

        for (int j = 0; j < m; j++) {
            int[] count = new int[n];
            for (int i = 0; i < n; i++) {
                count[i] = 1;
                for (int prev = 0; prev < i; prev++) {
                    if (grid[prev].charAt(j) <= grid[i].charAt(j)) {
                        count[i] = Math.max(count[i], dp[prev][k - 1] + 1);
                    }
                }
            }

            for (int i = 0; i < n; i++) {
                for (int t = 1; t <= k; t++) {
                    dp[i][t] = Math.max(dp[i][t], count[i]);
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result = Math.max(result, dp[i][k]);
        }
        return result;
    }
}
}