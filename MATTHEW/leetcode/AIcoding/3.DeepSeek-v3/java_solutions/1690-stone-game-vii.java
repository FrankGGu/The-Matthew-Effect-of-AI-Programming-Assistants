class Solution {
    public int stoneGameVII(int[] stones) {
        int n = stones.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }
        int[][] dp = new int[n][n];
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                int left = prefixSum[j + 1] - prefixSum[i + 1];
                int right = prefixSum[j] - prefixSum[i];
                dp[i][j] = Math.max(left - dp[i + 1][j], right - dp[i][j - 1]);
            }
        }
        return dp[0][n - 1];
    }
}