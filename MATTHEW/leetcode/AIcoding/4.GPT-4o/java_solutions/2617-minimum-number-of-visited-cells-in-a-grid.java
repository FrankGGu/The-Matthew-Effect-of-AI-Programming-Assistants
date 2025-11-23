import java.util.*;

class Solution {
    public int minimumVisitedCells(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        for (int[] row : dp) Arrays.fill(row, Integer.MAX_VALUE);
        dp[0][0] = 1;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0});

        while (!queue.isEmpty()) {
            int[] cell = queue.poll();
            int x = cell[0], y = cell[1];
            int steps = dp[x][y];

            for (int i = x + 1; i <= Math.min(m - 1, x + grid[x][y]); i++) {
                if (dp[i][y] > steps + 1) {
                    dp[i][y] = steps + 1;
                    queue.offer(new int[]{i, y});
                }
            }
            for (int j = y + 1; j <= Math.min(n - 1, y + grid[x][y]); j++) {
                if (dp[x][j] > steps + 1) {
                    dp[x][j] = steps + 1;
                    queue.offer(new int[]{x, j});
                }
            }
        }

        return dp[m - 1][n - 1] == Integer.MAX_VALUE ? -1 : dp[m - 1][n - 1];
    }
}