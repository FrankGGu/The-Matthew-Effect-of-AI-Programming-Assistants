import java.util.*;

class Solution {
    public int minimumVisitedCells(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 1});

        Set<Integer> visitedRows = new HashSet<>();
        Set<Integer> visitedCols = new HashSet<>();

        boolean[][] visited = new boolean[m][n];
        visited[0][0] = true;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int row = curr[0];
            int col = curr[1];
            int steps = curr[2];

            if (row == m - 1 && col == n - 1) {
                return steps;
            }

            int maxJump = grid[row][col];

            if (!visitedRows.contains(row)) {
                for (int j = col + 1; j <= Math.min(col + maxJump, n - 1); j++) {
                    if (!visited[row][j]) {
                        queue.offer(new int[]{row, j, steps + 1});
                        visited[row][j] = true;
                    }
                }
                visitedRows.add(row);
            }

            if (!visitedCols.contains(col)) {
                for (int i = row + 1; i <= Math.min(row + maxJump, m - 1); i++) {
                    if (!visited[i][col]) {
                        queue.offer(new int[]{i, col, steps + 1});
                        visited[i][col] = true;
                    }
                }
                visitedCols.add(col);
            }
        }

        return -1;
    }
}