class Solution {
    public int countIntegers(int num) {
        String s = String.valueOf(num);
        int n = s.length();
        int[][] dp = new int[n + 1][2];
        dp[0][0] = 1; // count of numbers less than 0
        dp[0][1] = 0; // count of numbers equal to 0

        for (int i = 1; i <= n; i++) {
            int digit = s.charAt(i - 1) - '0';
            for (int j = 0; j < 10; j++) {
                dp[i][1] += dp[i - 1][0]; // numbers less than the current prefix
                if (j < digit) {
                    dp[i][0] += dp[i - 1][0]; // numbers less than the current digit
                } else if (j == digit) {
                    dp[i][0] += dp[i - 1][1]; // numbers equal to the current prefix
                }
            }
            dp[i][1] += dp[i - 1][1]; // include the equal case
        }

        return dp[n][0] + dp[n][1];
    }
}