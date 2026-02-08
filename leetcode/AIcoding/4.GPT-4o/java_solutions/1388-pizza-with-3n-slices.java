class Solution {
    public int maxSizeSlices(int[] slices, int k) {
        int n = slices.length / 3;
        return Math.max(dp(slices, n, k), dp(reverse(slices), n, k));
    }

    private int dp(int[] slices, int n, int k) {
        int m = slices.length;
        int[][] dp = new int[k + 1][n + 1];
        for (int i = 0; i <= k; i++) {
            dp[i][0] = 0;
        }
        for (int j = 0; j <= n; j++) {
            dp[0][j] = 0;
        }
        for (int i = 1; i <= k; i++) {
            for (int j = 1; j <= n; j++) {
                for (int p = 0; p < m; p++) {
                    if (p >= j - 1) {
                        break;
                    }
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + slices[p]);
                }
            }
        }
        return dp[k][n];
    }

    private int[] reverse(int[] slices) {
        int n = slices.length;
        int[] reversed = new int[n];
        for (int i = 0; i < n; i++) {
            reversed[i] = slices[n - 1 - i];
        }
        return reversed;
    }
}