class Solution {
    public int minSteps(int[] rolls, int k) {
        int n = rolls.length;
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            dp[i] = Integer.MAX_VALUE;
            for (int j = 1; j <= k && i - j >= 0; j++) {
                dp[i] = Math.min(dp[i], dp[i - j] + rolls[i - 1]);
            }
        }
        return dp[n];
    }
}