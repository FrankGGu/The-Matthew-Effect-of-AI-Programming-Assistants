public class Solution {

import java.util.*;

public class Solution {
    public int minSkipsToArriveOnTime(int totalTrips, int[] time) {
        int n = time.length;
        double[][] dp = new double[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Double.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                if (j == 0) {
                    dp[i][j] = dp[i - 1][j] + time[i - 1];
                } else {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1] + time[i - 1]);
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j] + time[i - 1]);
                }
            }
        }

        for (int k = 0; k <= n; k++) {
            if (dp[n][k] <= totalTrips) {
                return k;
            }
        }
        return -1;
    }
}
}