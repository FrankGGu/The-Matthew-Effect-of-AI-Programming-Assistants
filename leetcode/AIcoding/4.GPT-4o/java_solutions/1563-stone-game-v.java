class Solution {
    public int stoneGameV(int[] stoneValue) {
        int n = stoneValue.length;
        int[][] dp = new int[n][n];

        for (int len = 1; len <= n; len++) {
            for (int i = 0; i + len - 1 < n; i++) {
                int j = i + len - 1;
                int sum = 0;
                for (int k = i; k < j; k++) {
                    sum += stoneValue[k];
                    if (sum <= sum(stoneValue, i, j)) {
                        dp[i][j] = Math.max(dp[i][j], sum + dp[i][k]);
                    }
                }
            }
        }

        return dp[0][n - 1];
    }

    private int sum(int[] stoneValue, int i, int j) {
        int total = 0;
        for (int k = i; k <= j; k++) {
            total += stoneValue[k];
        }
        return total;
    }
}