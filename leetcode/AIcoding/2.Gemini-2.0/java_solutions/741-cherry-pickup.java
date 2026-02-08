class Solution {
    public int cherryPickup(int[][] grid) {
        int n = grid.length;
        int[][][] dp = new int[n][n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    dp[i][j][k] = Integer.MIN_VALUE;
                }
            }
        }

        dp[0][0][0] = grid[0][0];

        for (int x1 = 0; x1 < n; x1++) {
            for (int y1 = 0; y1 < n; y1++) {
                for (int x2 = 0; x2 < n; x2++) {
                    int y2 = x1 + y1 - x2;

                    if (y2 < 0 || y2 >= n || grid[x1][y1] == -1 || grid[x2][y2] == -1) {
                        continue;
                    }

                    if (x1 > 0) {
                        dp[x1][y1][x2] = Math.max(dp[x1][y1][x2], dp[x1 - 1][y1][x2]);
                    }
                    if (x2 > 0) {
                        dp[x1][y1][x2] = Math.max(dp[x1][y1][x2], dp[x1][y1][x2 - 1]);
                    }
                    if (x1 > 0 && x2 > 0) {
                        dp[x1][y1][x2] = Math.max(dp[x1][y1][x2], dp[x1 - 1][y1][x2 - 1]);
                    }
                    if (x1 > 0 && y2 > 0) {
                        dp[x1][y1][x2] = Math.max(dp[x1][y1][x2], dp[x1 - 1][y1][x2][y2 - 1]);
                    }

                    if (dp[x1][y1][x2] != Integer.MIN_VALUE) {
                        dp[x1][y1][x2] += grid[x1][y1];
                        if (x1 != x2) {
                            dp[x1][y1][x2] += grid[x2][y2];
                        }
                    }
                }
            }
        }

        return Math.max(0, dp[n - 1][n - 1][n - 1]);
    }
}