class Solution {
    public double knightProbability(int n, int k, int row, int column) {
        if (k == 0) {
            return 1.0;
        }

        double[][] dp = new double[n][n];
        dp[row][column] = 1.0;

        int[] dr = {-2, -2, -1, -1, 1, 1, 2, 2};
        int[] dc = {-1, 1, -2, 2, -2, 2, -1, 1};

        for (int moves = 1; moves <= k; moves++) {
            double[][] nextDp = new double[n][n];
            for (int r = 0; r < n; r++) {
                for (int c = 0; c < n; c++) {
                    if (dp[r][c] > 0) {
                        for (int i = 0; i < 8; i++) {
                            int newR = r + dr[i];
                            int newC = c + dc[i];

                            if (newR >= 0 && newR < n && newC >= 0 && newC < n) {
                                nextDp[newR][newC] += dp[r][c] / 8.0;
                            }
                        }
                    }
                }
            }
            dp = nextDp;
        }

        double totalProbability = 0.0;
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                totalProbability += dp[r][c];
            }
        }

        return totalProbability;
    }
}