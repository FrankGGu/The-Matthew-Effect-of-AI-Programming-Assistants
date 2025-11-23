public class Solution {
    public int findNthValue(int n, int k) {
        int[] dp = new int[n + 1];
        dp[0] = 0;
        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + k;
        }
        return dp[n - 1];
    }
}