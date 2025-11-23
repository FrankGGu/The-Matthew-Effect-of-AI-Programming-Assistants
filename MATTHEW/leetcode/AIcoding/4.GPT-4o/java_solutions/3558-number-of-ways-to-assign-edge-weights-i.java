class Solution {
    public int numberOfWays(int n, int[][] relations, int k) {
        int mod = 1000000007;
        long[][] dp = new long[k + 1][n + 1];
        dp[0][1] = 1;

        for (int step = 1; step <= k; step++) {
            for (int[] relation : relations) {
                int u = relation[0], v = relation[1];
                dp[step][v] = (dp[step][v] + dp[step - 1][u]) % mod;
            }
            for (int i = 1; i <= n; i++) {
                dp[step][i] = (dp[step][i] + dp[step][i]) % mod;
            }
        }

        return (int) dp[k][n];
    }
}