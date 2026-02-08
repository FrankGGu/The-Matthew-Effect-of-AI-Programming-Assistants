public class Solution {
    public double knightProbability(int n, int k, int row, int col) {
        int[][] directions = {{2, 1}, {1, 2}, {-1, 2}, {-2, 1}, {-2, -1}, {-1, -2}, {1, -2}, {2, -1}};
        double[][] dp = new double[n][n];
        dp[row][col] = 1;

        for (int step = 0; step < k; step++) {
            double[][] next = new double[n][n];
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dp[i][j] > 0) {
                        for (int[] dir : directions) {
                            int ni = i + dir[0];
                            int nj = j + dir[1];
                            if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                                next[ni][nj] += dp[i][j] / 8;
                            }
                        }
                    }
                }
            }
            dp = next;
        }

        double total = 0;
        for (double[] arr : dp) {
            for (double val : arr) {
                total += val;
            }
        }
        return total;
    }
}