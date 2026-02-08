class Solution {
    public int maxSizeSlices(int[] slices) {
        int n = slices.length;
        int[] slices1 = new int[n - 1];
        int[] slices2 = new int[n - 1];
        for (int i = 0; i < n - 1; i++) {
            slices1[i] = slices[i];
            slices2[i] = slices[i + 1];
        }
        return Math.max(calculateMax(slices1, n / 3), calculateMax(slices2, n / 3));
    }

    private int calculateMax(int[] slices, int k) {
        int n = slices.length;
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                if (i == 1) {
                    dp[i][j] = slices[i - 1];
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], (i >= 2 ? dp[i - 2][j - 1] : 0) + slices[i - 1]);
                }
            }
        }
        return dp[n][k];
    }
}