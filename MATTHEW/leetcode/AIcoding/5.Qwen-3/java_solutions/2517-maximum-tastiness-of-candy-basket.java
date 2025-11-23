public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxTastiness(int[] price, int k) {
        Arrays.sort(price);
        int n = price.length;
        int[][] dp = new int[k + 1][n];

        for (int i = 0; i < n; i++) {
            dp[0][i] = 0;
        }

        for (int i = 1; i <= k; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 1) {
                    dp[i][j] = price[j];
                } else {
                    dp[i][j] = 0;
                    for (int m = 0; m < j; m++) {
                        dp[i][j] = Math.max(dp[i][j], dp[i - 1][m] + price[j]);
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result = Math.max(result, dp[k][i]);
        }
        return result;
    }
}
}