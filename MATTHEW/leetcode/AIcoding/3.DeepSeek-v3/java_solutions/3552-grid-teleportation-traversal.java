import java.util.*;

class Solution {
    public boolean canReach(int[][] grid, int startX, int startY, int endX, int endY) {
        int m = grid.length;
        int n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{startX, startY});
        visited[startX][startY] = true;

        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int x = current[0];
            int y = current[1];

            if (x == endX && y == endY) {
                return true;
            }

            for (int[] dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] == 0) {
                    visited[nx][ny] = true;
                    queue.offer(new int[]{nx, ny});
                }
            }

            int teleX = m - 1 - x;
            int teleY = n - 1 - y;

            if (!visited[teleX][teleY] && grid[teleX][teleY] == 0) {
                visited[teleX][teleY] = true;
                queue.offer(new int[]{teleX, teleY});
            }
        }

        return false;
    }
}