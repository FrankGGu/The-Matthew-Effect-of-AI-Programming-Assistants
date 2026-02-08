class Solution {
    public long numberOfWays(String s) {
        long ans = 0;
        int n = s.length();
        long[][] dp = new long[n][3];
        if (s.charAt(0) == '0') {
            dp[0][0] = 1;
        } else {
            dp[0][1] = 1;
        }
        for (int i = 1; i < n; i++) {
            if (s.charAt(i) == '0') {
                dp[i][0] = dp[i - 1][0] + 1;
                dp[i][1] = dp[i - 1][1];
                dp[i][2] = dp[i - 1][2] + dp[i - 1][1];
            } else {
                dp[i][0] = dp[i - 1][0];
                dp[i][1] = dp[i - 1][1] + 1;
                dp[i][2] = dp[i - 1][2] + dp[i - 1][0];
            }
        }
        return dp[n - 1][2];
    }
}