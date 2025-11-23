class Solution {
    private int[][] dirs = new int[][]{{1, 2}, {1, -2}, {-1, 2}, {-1, -2}, {2, 1}, {2, -1}, {-2, 1}, {-2, -1}};

    public double knightProbability(int n, int k, int row, int column) {
        double[][][] dp = new double[k + 1][n][n];
        dp[0][row][column] = 1.0;

        for (int move = 1; move <= k; move++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    for (int[] dir : dirs) {
                        int prevI = i - dir[0];
                        int prevJ = j - dir[1];
                        if (prevI >= 0 && prevI < n && prevJ >= 0 && prevJ < n) {
                            dp[move][i][j] += dp[move - 1][prevI][prevJ] / 8.0;
                        }
                    }
                }
            }
        }

        double res = 0.0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                res += dp[k][i][j];
            }
        }
        return res;
    }
}