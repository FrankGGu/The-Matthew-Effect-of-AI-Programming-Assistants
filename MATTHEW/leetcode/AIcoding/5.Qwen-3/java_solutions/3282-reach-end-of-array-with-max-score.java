public class Solution {
    public int maxScore(int[] arr) {
        int n = arr.length;
        int[] dp = new int[n];
        dp[0] = arr[0];

        for (int i = 1; i < n; i++) {
            dp[i] = arr[i];
            for (int j = 1; j <= i; j++) {
                if (i - j >= 0) {
                    dp[i] = Math.max(dp[i], arr[i] + dp[i - j]);
                }
            }
        }

        return dp[n - 1];
    }
}