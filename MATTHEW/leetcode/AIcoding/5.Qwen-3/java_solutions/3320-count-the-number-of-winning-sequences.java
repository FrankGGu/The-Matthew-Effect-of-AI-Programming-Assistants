public class Solution {

import java.util.*;

public class Solution {
    public int countTheNumOfWinningSequences(int n) {
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            dp[0][i] = 1;
        }
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                if (j >= i) {
                    dp[i][j] = dp[i - 1][j - i] + dp[i - 1][j];
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }
        return dp[n][n];
    }
}
}