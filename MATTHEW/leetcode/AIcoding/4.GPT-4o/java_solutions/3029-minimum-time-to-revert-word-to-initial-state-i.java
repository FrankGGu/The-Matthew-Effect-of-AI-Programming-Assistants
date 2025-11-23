class Solution {
    public int minimumTime(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i] = Integer.MAX_VALUE;
            if (s.charAt(i - 1) == '0') {
                dp[i] = Math.min(dp[i], dp[i - 1] + 1);
            }
            if (i > 1 && s.charAt(i - 1) == '1' && s.charAt(i - 2) == '1') {
                dp[i] = Math.min(dp[i], dp[i - 2] + 2);
            }
        }

        return dp[n];
    }
}