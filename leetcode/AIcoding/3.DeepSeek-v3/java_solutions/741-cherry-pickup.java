class Solution {
    public int cherryPickup(int[][] grid) {
        int N = grid.length;
        int[][][] dp = new int[N][N][N];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                for (int k = 0; k < N; k++) {
                    dp[i][j][k] = Integer.MIN_VALUE;
                }
            }
        }
        dp[0][0][0] = grid[0][0];

        for (int t = 1; t <= 2*N - 2; t++) {
            for (int i = Math.max(0, t - (N - 1)); i <= Math.min(N - 1, t); i++) {
                for (int j = Math.max(0, t - (N - 1)); j <= Math.min(N - 1, t); j++) {
                    int k = t - i;
                    int l = t - j;
                    if (grid[i][k] == -1 || grid[j][l] == -1) {
                        continue;
                    }
                    int val = grid[i][k];
                    if (i != j || k != l) {
                        val += grid[j][l];
                    }
                    int max = Integer.MIN_VALUE;
                    if (i > 0 && j > 0) max = Math.max(max, dp[i-1][j-1][k]);
                    if (i > 0 && l > 0) max = Math.max(max, dp[i-1][j][k-1]);
                    if (k > 0 && j > 0) max = Math.max(max, dp[i][j-1][k]);
                    if (k > 0 && l > 0) max = Math.max(max, dp[i][j][k-1]);
                    if (max == Integer.MIN_VALUE) continue;
                    dp[i][j][k] = max + val;
                }
            }
        }
        return Math.max(0, dp[N-1][N-1][N-1]);
    }
}