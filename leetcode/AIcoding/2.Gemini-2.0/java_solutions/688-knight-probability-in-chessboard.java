class Solution {
    public double knightProbability(int n, int k, int row, int column) {
        double[][][] dp = new double[k + 1][n][n];
        int[][] moves = {{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 1}};

        dp[0][row][column] = 1;

        for (int move = 1; move <= k; move++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    for (int[] m : moves) {
                        int prevRow = i - m[0];
                        int prevCol = j - m[1];

                        if (prevRow >= 0 && prevRow < n && prevCol >= 0 && prevCol < n) {
                            dp[move][i][j] += dp[move - 1][prevRow][prevCol] / 8.0;
                        }
                    }
                }
            }
        }

        double totalProbability = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                totalProbability += dp[k][i][j];
            }
        }

        return totalProbability;
    }
}