class Solution {
    public double minimumDistance(String word) {
        int n = word.length();
        if (n == 0) return 0.0;
        if (n == 1) return 0.0;

        int[][] pos = new int[26][2];
        for (int i = 0; i < 26; i++) {
            pos[i][0] = i / 6;
            pos[i][1] = i % 6;
        }

        double[][][] dp = new double[n][27][27];
        for (double[][] row : dp) {
            for (double[] r : row) {
                Arrays.fill(r, Double.MAX_VALUE);
            }
        }

        for (int i = 0; i < 27; i++) {
            dp[0][i][26] = 0;
            dp[0][26][i] = 0;
        }

        for (int i = 0; i < n; i++) {
            int c = word.charAt(i) - 'A';
            for (int j = 0; j < 27; j++) {
                for (int k = 0; k < 27; k++) {
                    if (dp[i][j][k] == Double.MAX_VALUE) continue;
                    dp[i + 1][c][j] = Math.min(dp[i + 1][c][j], dp[i][j][k] + getDistance(pos[c], pos[j]));
                    dp[i + 1][j][c] = Math.min(dp[i + 1][j][c], dp[i][j][k] + getDistance(pos[c], pos[k]));
                }
            }
        }

        double minDistance = Double.MAX_VALUE;
        for (int j = 0; j < 27; j++) {
            for (int k = 0; k < 27; k++) {
                minDistance = Math.min(minDistance, dp[n][j][k]);
            }
        }
        return minDistance;
    }

    private double getDistance(int[] a, int[] b) {
        return Math.sqrt((a[0] - b[0]) * (a[0] - b[0]) + (a[1] - b[1]) * (a[1] - b[1]));
    }
}