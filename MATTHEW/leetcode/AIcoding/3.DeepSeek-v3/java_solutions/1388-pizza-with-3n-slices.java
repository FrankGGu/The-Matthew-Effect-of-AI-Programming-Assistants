class Solution {
    public int maxSizeSlices(int[] slices) {
        int n = slices.length / 3;
        return Math.max(helper(slices, 0, slices.length - 2, n), helper(slices, 1, slices.length - 1, n));
    }

    private int helper(int[] slices, int start, int end, int n) {
        int[][] dp = new int[end - start + 2][n + 1];
        for (int i = 1; i <= end - start + 1; i++) {
            for (int j = 1; j <= n; j++) {
                if (i == 1) {
                    dp[i][j] = slices[start + i - 1];
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], dp[i - 2][j - 1] + slices[start + i - 1]);
                }
            }
        }
        return dp[end - start + 1][n];
    }
}