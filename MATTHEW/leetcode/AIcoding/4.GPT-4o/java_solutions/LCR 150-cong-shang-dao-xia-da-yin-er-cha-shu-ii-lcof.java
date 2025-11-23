class Solution {
    public int rotateLights(int[] lights) {
        int n = lights.length;
        if (n == 0) return 0;

        int[] dp = new int[n + 1];
        dp[0] = 0;
        dp[1] = lights[0];

        for (int i = 2; i <= n; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + lights[i - 1]);
        }

        return dp[n];
    }
}