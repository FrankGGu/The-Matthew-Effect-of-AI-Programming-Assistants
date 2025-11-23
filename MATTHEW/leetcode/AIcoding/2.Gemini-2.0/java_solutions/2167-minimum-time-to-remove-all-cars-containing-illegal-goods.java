class Solution {
    public int minimumTime(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + 1;
            if (s.charAt(i - 1) == '1') {
                dp[i] = Math.min(dp[i], (i > 1 ? dp[i - 2] : 0) + 2);
            }
        }

        return dp[n];
    }
}