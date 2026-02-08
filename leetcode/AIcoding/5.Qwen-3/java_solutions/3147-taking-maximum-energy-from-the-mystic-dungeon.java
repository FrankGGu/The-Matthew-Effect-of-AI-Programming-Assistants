public class Solution {

import java.util.*;

public class Solution {
    public int maxEnergy(int[][] energy, int k) {
        int n = energy.length;
        int m = energy[0].length;
        int[][] dp = new int[n][m];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Integer.MIN_VALUE);
        }
        for (int j = 0; j < m; j++) {
            dp[0][j] = energy[0][j];
        }
        for (int i = 1; i < n; i++) {
            for (int j = 0; j < m; j++) {
                int maxPrev = Integer.MIN_VALUE;
                for (int dj = Math.max(0, j - k); dj <= Math.min(m - 1, j + k); dj++) {
                    if (dp[i - 1][dj] > maxPrev) {
                        maxPrev = dp[i - 1][dj];
                    }
                }
                dp[i][j] = maxPrev + energy[i][j];
            }
        }
        int result = Integer.MIN_VALUE;
        for (int j = 0; j < m; j++) {
            if (dp[n - 1][j] > result) {
                result = dp[n - 1][j];
            }
        }
        return result;
    }
}
}