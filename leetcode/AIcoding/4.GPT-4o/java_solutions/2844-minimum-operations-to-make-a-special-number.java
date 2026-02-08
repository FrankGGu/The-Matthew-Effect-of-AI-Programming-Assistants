class Solution {
    public int minimumOperations(String num) {
        int n = num.length();
        int[] dp = new int[n + 1];
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + (num.charAt(i - 1) == '0' ? 1 : 0);
            if (i > 1) {
                dp[i] = Math.min(dp[i], dp[i - 2] + (num.charAt(i - 1) == '0' ? 1 : 0) + (num.charAt(i - 2) == '0' ? 1 : 0));
            }
        }

        return dp[n];
    }
}