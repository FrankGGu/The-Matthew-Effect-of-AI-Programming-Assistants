import java.util.*;

class Solution {
    public int crackPassword(String password) {
        int n = password.length();
        int[] dp = new int[n + 1];
        dp[0] = 1;
        for (int i = 1; i <= n; i++) {
            dp[i] = 0;
            if (password.charAt(i - 1) != '0') {
                dp[i] += dp[i - 1];
            }
            if (i >= 2) {
                int num = Integer.parseInt(password.substring(i - 2, i));
                if (num >= 10 && num <= 26) {
                    dp[i] += dp[i - 2];
                }
            }
        }
        return dp[n];
    }
}