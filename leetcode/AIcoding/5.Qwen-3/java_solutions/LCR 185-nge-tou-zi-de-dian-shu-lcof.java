public class Solution {

import java.util.*;

public class Solution {
    public double[] stats(int n, int k, int s) {
        double[][] dp = new double[n + 1][s + 1];
        dp[0][0] = 1.0;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= s; j++) {
                for (int x = 1; x <= k && j - x >= 0; x++) {
                    dp[i][j] += dp[i - 1][j - x] / k;
                }
            }
        }
        double[] result = new double[s + 1];
        for (int i = 0; i <= s; i++) {
            result[i] = dp[n][i];
        }
        return result;
    }
}
}