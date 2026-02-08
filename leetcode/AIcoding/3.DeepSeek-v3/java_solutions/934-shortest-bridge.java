import java.util.LinkedList;
import java.util.Queue;

class Solution {
    private int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int shortestBridge(int[][] grid) {
        int n = grid.length;
        boolean[][] visited = new boolean[n][n];
        Queue<int[]> queue = new LinkedList<>();
        boolean found = false;

        for (int i = 0; i < n && !found; i++) {
            for (int j = 0; j < n && !found; j++) {
                if (grid[i][j] == 1) {
                    dfs(grid, i, j, visited, queue);
                    found = true;
                }
            }
        }

        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] cell = queue.poll();
                for (int[] dir : dirs) {
                    int x = cell[0] + dir[0];
                    int y = cell[1] + dir[1];
                    if (x >= 0 && y >= 0 && x < n && y < n && !visited[x][y]) {
                        if (grid[x][y] == 1) {
                            return steps;
                        }
                        visited[x][y] = true;
                        queue.offer(new int[]{x, y});
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    private void dfs(int[][] grid, int i, int j, boolean[][] visited, Queue<int[]> queue) {
        if (i < 0 || j < 0 || i >= grid.length || j >= grid.length || visited[i][j] || grid[i][j] != 1) {
            return;
        }
        visited[i][j] = true;
        queue.offer(new int[]{i, j});
        for (int[] dir : dirs) {
            dfs(grid, i + dir[0], j + dir[1], visited, queue);
        }
    }
}