public class Solution {

import java.util.*;

public class Solution {
    public int minTimeToBreakLocks(int[] locks, int[] keys) {
        int n = locks.length;
        int m = keys.length;
        int[][] dp = new int[n + 1][m + 1];

        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= m; j++) {
                if (dp[i][j] == Integer.MAX_VALUE) continue;

                // Option 1: do not use any key for this lock
                dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j] + locks[i]);

                // Option 2: use a key for this lock
                for (int k = j; k < m; k++) {
                    dp[i + 1][k + 1] = Math.min(dp[i + 1][k + 1], dp[i][j] + keys[k]);
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j <= m; j++) {
            result = Math.min(result, dp[n][j]);
        }

        return result;
    }
}
}