import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int shortestPath(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;

        if (k >= m + n - 2) {
            return m + n - 2;
        }

        Queue<int[]> queue = new LinkedList<>();
        boolean[][][] visited = new boolean[m][n][k + 1];

        queue.offer(new int[]{0, 0, k, 0});
        visited[0][0][k] = true;

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];
            int currentK = current[2];
            int steps = current[3];

            if (r == m - 1 && c == n - 1) {
                return steps;
            }

            for (int[] dir : directions) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    if (grid[nr][nc] == 0) { // Empty cell
                        if (!visited[nr][nc][currentK]) {
                            visited[nr][nc][currentK] = true;
                            queue.offer(new int[]{nr, nc, currentK, steps + 1});
                        }
                    } else { // Obstacle (grid[nr][nc] == 1)
                        if (currentK > 0) { // Can eliminate an obstacle
                            int newK = currentK - 1;
                            if (!visited[nr][nc][newK]) {
                                visited[nr][nc][newK] = true;
                                queue.offer(new int[]{nr, nc, newK, steps + 1});
                            }
                        }
                    }
                }
            }
        }

        return -1;
    }
}