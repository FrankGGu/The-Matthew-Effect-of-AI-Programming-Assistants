class Solution {
    public int beautifulTowers(int[] heights) {
        int n = heights.length;
        int[] dp = new int[n];
        int maxTowers = 0;

        for (int i = 0; i < n; i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                if (heights[j] < heights[i]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            maxTowers = Math.max(maxTowers, dp[i]);
        }

        return maxTowers;
    }
}