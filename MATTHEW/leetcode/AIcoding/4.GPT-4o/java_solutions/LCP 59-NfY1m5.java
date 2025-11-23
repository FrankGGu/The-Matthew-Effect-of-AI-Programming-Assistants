public class Solution {
    public int maxBridge(int[][] positions) {
        int n = positions.length;
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = -1;
            }
        }
        int[] x = new int[n];
        int[] y = new int[n];
        for (int i = 0; i < n; i++) {
            x[i] = positions[i][0];
            y[i] = positions[i][1];
        }
        Arrays.sort(x);
        Arrays.sort(y);
        return dfs(x, y, 0, 0, dp);
    }

    private int dfs(int[] x, int[] y, int i, int j, int[][] dp) {
        if (i == x.length || j == y.length) return 0;
        if (dp[i][j] != -1) return dp[i][j];
        int max = 0;
        for (int k = j; k < y.length; k++) {
            if (y[k] > x[i]) {
                max = Math.max(max, 1 + dfs(x, y, i + 1, k + 1, dp));
            }
        }
        return dp[i][j] = max;
    }
}