public class Solution {
    public int stoneGameVII(int[] stones) {
        int n = stones.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + stones[i];
        }
        int[][] dp = new int[n][n];
        for (int length = 2; length <= n; length++) {
            for (int i = 0; i + length <= n; i++) {
                int j = i + length - 1;
                dp[i][j] = Math.max(stones[i] + (prefix[j] - prefix[i + 1]), stones[j] + (prefix[j - 1] - prefix[i]));
            }
        }
        return dp[0][n - 1];
    }
}