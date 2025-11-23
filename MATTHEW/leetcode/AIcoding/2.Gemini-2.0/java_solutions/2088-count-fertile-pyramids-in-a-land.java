class Solution {
    public int countFertilePyramids(int[][] land) {
        int m = land.length;
        int n = land[0].length;
        int[][] dp = new int[m][n];
        int count = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (land[i][j] == 1) {
                    dp[i][j] = 1;
                    if (i > 0 && j > 0 && j < n - 1) {
                        dp[i][j] += Math.min(dp[i - 1][j - 1], Math.min(dp[i - 1][j], dp[i - 1][j + 1]));
                    }
                    count += dp[i][j] - 1;
                }
            }
        }

        dp = new int[m][n];
        for (int i = m - 1; i >= 0; i--) {
            for (int j = 0; j < n; j++) {
                if (land[i][j] == 1) {
                    dp[i][j] = 1;
                    if (i < m - 1 && j > 0 && j < n - 1) {
                        dp[i][j] += Math.min(dp[i + 1][j - 1], Math.min(dp[i + 1][j], dp[i + 1][j + 1]));
                    }
                    count += dp[i][j] - 1;
                }
            }
        }

        return count;
    }
}