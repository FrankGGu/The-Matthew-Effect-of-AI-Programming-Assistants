public class Solution {
    public int peopleAwareOfSecret(int n, int k) {
        int[] dp = new int[n + 1];
        dp[1] = 1;
        for (int i = 2; i <= n; i++) {
            if (i - k >= 1) {
                dp[i] = dp[i - 1] + dp[i - k];
            } else {
                dp[i] = dp[i - 1];
            }
        }
        return dp[n];
    }
}