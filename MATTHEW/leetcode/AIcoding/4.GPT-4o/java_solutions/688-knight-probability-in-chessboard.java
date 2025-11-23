class Solution {
    public double knightProbability(int n, int k, int row, int column) {
        double[][] dp = new double[n][n];
        dp[row][column] = 1.0;

        int[][] directions = {
            {2, 1}, {2, -1}, {-2, 1}, {-2, -1},
            {1, 2}, {1, -2}, {-1, 2}, {-1, -2}
        };

        for (int step = 0; step < k; step++) {
            double[][] newDp = new double[n][n];
            for (int r = 0; r < n; r++) {
                for (int c = 0; c < n; c++) {
                    for (int[] dir : directions) {
                        int newRow = r + dir[0];
                        int newCol = c + dir[1];
                        if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n) {
                            newDp[newRow][newCol] += dp[r][c] / 8;
                        }
                    }
                }
            }
            dp = newDp;
        }

        double probability = 0.0;
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                probability += dp[r][c];
            }
        }

        return probability;
    }
}