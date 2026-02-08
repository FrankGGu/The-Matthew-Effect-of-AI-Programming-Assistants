import java.util.*;

class Solution {
    public int maxIncreasingCells(int[][] mat) {
        int n = mat.length, m = mat[0].length;
        int[][] dp = new int[n][m];
        List<int[]> cells = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                cells.add(new int[]{mat[i][j], i, j});
            }
        }

        cells.sort((a, b) -> a[0] - b[0]);

        int maxCells = 0;
        for (int[] cell : cells) {
            int x = cell[1], y = cell[2];
            dp[x][y] = 1;
            for (int i = 0; i < n; i++) {
                if (i != x && mat[i][y] < mat[x][y]) {
                    dp[x][y] = Math.max(dp[x][y], dp[i][y] + 1);
                }
            }
            for (int j = 0; j < m; j++) {
                if (j != y && mat[x][j] < mat[x][y]) {
                    dp[x][y] = Math.max(dp[x][y], dp[x][j] + 1);
                }
            }
            maxCells = Math.max(maxCells, dp[x][y]);
        }

        return maxCells;
    }
}