class Solution {
    public int stoneGameVIII(int[] stones) {
        int n = stones.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        int[] dp = new int[n];
        dp[n - 1] = prefixSum[n] - prefixSum[n - 1];

        for (int i = n - 2; i >= 1; i--) {
            dp[i] = Math.max(prefixSum[i + 1] - prefixSum[0], -dp[i + 1]);
        }

        return dp[1];
    }
}