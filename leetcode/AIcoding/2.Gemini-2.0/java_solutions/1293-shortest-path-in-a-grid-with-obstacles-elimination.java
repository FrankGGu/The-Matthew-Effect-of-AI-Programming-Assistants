import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int shortestPath(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;

        if (m == 1 && n == 1) {
            return 0;
        }

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        boolean[][][] visited = new boolean[m][n][k + 1];
        Queue<int[]> queue = new LinkedList<>();

        queue.offer(new int[]{0, 0, k, 0}); // row, col, remaining eliminations, steps
        visited[0][0][k] = true;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int row = curr[0];
            int col = curr[1];
            int eliminations = curr[2];
            int steps = curr[3];

            if (row == m - 1 && col == n - 1) {
                return steps;
            }

            for (int[] dir : directions) {
                int newRow = row + dir[0];
                int newCol = col + dir[1];

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                    if (grid[newRow][newCol] == 0) {
                        if (!visited[newRow][newCol][eliminations]) {
                            queue.offer(new int[]{newRow, newCol, eliminations, steps + 1});
                            visited[newRow][newCol][eliminations] = true;
                        }
                    } else {
                        if (eliminations > 0 && !visited[newRow][newCol][eliminations - 1]) {
                            queue.offer(new int[]{newRow, newCol, eliminations - 1, steps + 1});
                            visited[newRow][newCol][eliminations - 1] = true;
                        }
                    }
                }
            }
        }

        return -1;
    }
}