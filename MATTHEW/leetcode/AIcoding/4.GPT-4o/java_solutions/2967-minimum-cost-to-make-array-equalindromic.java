class Solution {
    public int minCost(int[] A) {
        int n = A.length;
        int[][] dp = new int[n][n];

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (A[i] == A[j]) {
                    dp[i][j] = dp[i + 1][j - 1];
                } else {
                    dp[i][j] = Math.min(dp[i + 1][j] + A[i], dp[i][j - 1] + A[j]);
                }
            }
        }

        return dp[0][n - 1];
    }
}