class Solution {
    public int maxPeople(int[] A, int[] B) {
        int n = A.length;
        int[][] dp = new int[n + 1][n + 1];

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= A[i - 1]) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - A[i - 1]] + B[i - 1]);
                }
            }
        }

        return dp[n][n];
    }
}