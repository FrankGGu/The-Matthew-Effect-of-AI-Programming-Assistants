public class Solution {

import java.util.*;

public class Solution {
    public int numberOfWays(String s) {
        int n = s.length();
        long[][] dp = new long[n][2];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 2; j++) {
                dp[i][j] = 0;
            }
        }
        for (int i = 1; i < n; i++) {
            if (s.charAt(i) != '0') {
                dp[i][0] = dp[i - 1][0] + 1;
            }
            if (s.charAt(i) == '0') {
                dp[i][1] = dp[i - 1][1] + dp[i - 1][0];
            } else {
                dp[i][1] = dp[i - 1][1];
            }
        }
        return (int) dp[n - 1][1];
    }
}
}