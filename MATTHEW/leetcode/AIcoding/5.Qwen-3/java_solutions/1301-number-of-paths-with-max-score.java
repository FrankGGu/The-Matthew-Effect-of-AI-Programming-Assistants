public class Solution {
    public int[] pathWithMaxScore(int[][] grid) {
        int n = grid.length;
        int[][] dp = new int[n][n];
        int[][] count = new int[n][n];
        char[][] g = new char[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                g[i][j] = (char) ('0' + grid[i][j]);
            }
        }

        dp[n - 1][n - 1] = 0;
        count[n - 1][n - 1] = 1;

        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (i == n - 1 && j == n - 1) continue;
                if (g[i][j] == '0') {
                    dp[i][j] = -1;
                    continue;
                }
                int maxVal = -1;
                int total = 0;
                if (i + 1 < n) {
                    if (dp[i + 1][j] != -1) {
                        maxVal = Math.max(maxVal, dp[i + 1][j]);
                    }
                }
                if (j + 1 < n) {
                    if (dp[i][j + 1] != -1) {
                        maxVal = Math.max(maxVal, dp[i][j + 1]);
                    }
                }
                if (i + 1 < n && j + 1 < n) {
                    if (dp[i + 1][j + 1] != -1) {
                        maxVal = Math.max(maxVal, dp[i + 1][j + 1]);
                    }
                }
                if (maxVal != -1) {
                    dp[i][j] = maxVal + (g[i][j] - '0');
                    if (i + 1 < n && dp[i + 1][j] == maxVal) {
                        total += count[i + 1][j];
                    }
                    if (j + 1 < n && dp[i][j + 1] == maxVal) {
                        total += count[i][j + 1];
                    }
                    if (i + 1 < n && j + 1 < n && dp[i + 1][j + 1] == maxVal) {
                        total += count[i + 1][j + 1];
                    }
                    count[i][j] = total;
                } else {
                    dp[i][j] = -1;
                }
            }
        }

        return new int[]{dp[0][0], count[0][0]};
    }
}