import java.util.Arrays;

class Solution {
    public int maximumMoves(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        int[][] dp = new int[rows][cols];

        for (int i = 0; i < rows; i++) {
            Arrays.fill(dp[i], -1);
        }

        for (int r = 0; r < rows; r++) {
            dp[r][0] = 0;
        }

        int maxMoves = 0;

        for (int c = 0; c < cols - 1; c++) {
            for (int r = 0; r < rows; r++) {
                if (dp[r][c] == -1) {
                    continue;
                }

                int currentVal = grid[r][c];
                int currentMoves = dp[r][c];

                // Move to (r-1, c+1)
                if (r - 1 >= 0 && grid[r - 1][c + 1] > currentVal) {
                    dp[r - 1][c + 1] = Math.max(dp[r - 1][c + 1], currentMoves + 1);
                    maxMoves = Math.max(maxMoves, dp[r - 1][c + 1]);
                }

                // Move to (r, c+1)
                if (grid[r][c + 1] > currentVal) {
                    dp[r][c + 1] = Math.max(dp[r][c + 1], currentMoves + 1);
                    maxMoves = Math.max(maxMoves, dp[r][c + 1]);
                }

                // Move to (r+1, c+1)
                if (r + 1 < rows && grid[r + 1][c + 1] > currentVal) {
                    dp[r + 1][c + 1] = Math.max(dp[r + 1][c + 1], currentMoves + 1);
                    maxMoves = Math.max(maxMoves, dp[r + 1][c + 1]);
                }
            }
        }

        return maxMoves;
    }
}