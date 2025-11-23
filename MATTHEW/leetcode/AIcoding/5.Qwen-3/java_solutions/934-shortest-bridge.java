public class Solution {

import java.util.*;

public class Solution {
    int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int shortestBridge(int[][] grid) {
        int n = grid.length;
        boolean found = false;
        Queue<int[]> queue = new LinkedList<>();

        for (int i = 0; i < n && !found; i++) {
            for (int j = 0; j < n && !found; j++) {
                if (grid[i][j] == 1) {
                    dfs(grid, i, j, queue);
                    found = true;
                }
            }
        }

        while (!queue.isEmpty()) {
            int[] cell = queue.poll();
            int x = cell[0], y = cell[1];
            for (int[] dir : dirs) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && ny >= 0 && nx < n && ny < n && grid[nx][ny] == 0) {
                    grid[nx][ny] = -1;
                    queue.add(new int[]{nx, ny});
                }
            }
        }

        return 0;
    }

    private void dfs(int[][] grid, int x, int y, Queue<int[]> queue) {
        if (x < 0 || y < 0 || x >= grid.length || y >= grid.length || grid[x][y] != 1) {
            return;
        }
        grid[x][y] = -1;
        queue.add(new int[]{x, y});
        for (int[] dir : dirs) {
            dfs(grid, x + dir[0], y + dir[1], queue);
        }
    }
}
}