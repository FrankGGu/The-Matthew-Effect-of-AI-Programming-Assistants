public class Solution {
    public int minimumWhiteTiles(String s, int k) {
        int n = s.length();
        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            dp[i + 1] = dp[i] + (s.charAt(i) == 'w' ? 1 : 0);
        }
        for (int i = 1; i <= n; i++) {
            if (i - k >= 0) {
                dp[i] = Math.min(dp[i], dp[i - k - 1] + dp[i] - dp[i - k]);
            }
        }
        return dp[n];
    }
}