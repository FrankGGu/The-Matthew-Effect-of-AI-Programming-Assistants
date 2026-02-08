class Solution {
    public int numberOfKeys(String str) {
        int n = str.length();
        int[] dp = new int[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            if (i > 1 && str.charAt(i - 1) == str.charAt(i - 2)) {
                dp[i] += dp[i - 2];
            }
        }

        return dp[n];
    }
}