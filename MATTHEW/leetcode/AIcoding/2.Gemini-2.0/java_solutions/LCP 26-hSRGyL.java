class Solution {
    public int navigation(int[] target) {
        int n = target.length;
        int[] dp = new int[n + 1];
        dp[0] = 0;
        dp[1] = 1;
        for (int i = 2; i <= n; i++) {
            dp[i] = dp[i - 1] + 1;
            if (target[i - 1] == target[i - 2]) {
                dp[i] = Math.min(dp[i], dp[i - 2] + 1);
            }
        }
        return dp[n];
    }
}