class Solution {
    public int maximumDeletions(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            if (i > 1 && s.charAt(i - 1) != s.charAt(i - 2)) {
                dp[i] = Math.max(dp[i], dp[i - 2] + 1);
            }
        }

        return dp[n];
    }
}