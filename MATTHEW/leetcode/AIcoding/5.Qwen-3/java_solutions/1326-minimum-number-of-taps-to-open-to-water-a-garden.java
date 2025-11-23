public class Solution {
    public int minTaps(int n) {
        int[] dp = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            dp[i] = n + 1;
        }
        dp[0] = 0;
        for (int i = 0; i <= n; i++) {
            int start = Math.max(0, i - dp[i]);
            int end = Math.min(n, i + dp[i]);
            for (int j = start; j <= end; j++) {
                dp[j] = Math.min(dp[j], dp[i] + 1);
            }
        }
        return dp[n] == n + 1 ? -1 : dp[n];
    }
}