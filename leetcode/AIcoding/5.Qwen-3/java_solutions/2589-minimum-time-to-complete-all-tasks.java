public class Solution {

import java.util.*;

public class Solution {
    public int minimumTimeToCompleteAllTasks(int[] tasks) {
        int n = tasks.length;
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            dp[i][i] = tasks[i];
        }
        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                dp[i][j] = Math.min(dp[i][j - 1] + tasks[j], dp[i + 1][j] + tasks[i]);
            }
        }
        return dp[0][n - 1];
    }
}
}