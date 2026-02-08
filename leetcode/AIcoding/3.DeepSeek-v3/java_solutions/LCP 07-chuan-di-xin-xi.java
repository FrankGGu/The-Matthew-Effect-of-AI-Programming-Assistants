class Solution {
    public int numWays(int n, int[][] relation, int k) {
        int[][] dp = new int[k + 1][n];
        dp[0][0] = 1;
        for (int i = 1; i <= k; i++) {
            for (int[] edge : relation) {
                int from = edge[0], to = edge[1];
                dp[i][to] += dp[i - 1][from];
            }
        }
        return dp[k][n - 1];
    }
}