class Solution {
    public int countNumbersWithUniqueDigits(int n) {
        if (n == 0) {
            return 1;
        }
        if (n > 10) {
            n = 10;
        }
        int[] dp = new int[n + 1];
        dp[0] = 1;
        dp[1] = 10;
        int ans = 10;
        for (int i = 2; i <= n; i++) {
            dp[i] = dp[i - 1] + (dp[i - 1] - dp[i - 2]) * (10 - (i - 1));
            ans += (dp[i] - dp[i - 1]);
        }
        return ans;
    }

    public int countNumbersWithNonDecreasingDigits(int n) {
        int[][] dp = new int[n + 1][10];
        for (int j = 0; j < 10; j++) {
            dp[1][j] = 1;
        }
        for (int i = 2; i <= n; i++) {
            for (int j = 0; j < 10; j++) {
                for (int k = j; k < 10; k++) {
                    dp[i][j] += dp[i - 1][k];
                }
            }
        }
        int ans = 0;
        for (int j = 0; j < 10; j++) {
            ans += dp[n][j];
        }
        return ans;
    }
}