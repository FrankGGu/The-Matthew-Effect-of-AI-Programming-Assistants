class Solution {
    public int shortestBridge(int[][] grid) {
        int n = grid.length;
        boolean[][] visited = new boolean[n][n];
        Queue<int[]> queue = new LinkedList<>();
        boolean found = false;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1 && !found) {
                    dfs(grid, i, j, visited, queue);
                    found = true;
                }
            }
        }

        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                for (int[] dir : new int[][]{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}) {
                    int x = curr[0] + dir[0], y = curr[1] + dir[1];
                    if (x >= 0 && x < n && y >= 0 && y < n) {
                        if (grid[x][y] == 1) {
                            return steps;
                        }
                        if (grid[x][y] == 0 && !visited[x][y]) {
                            visited[x][y] = true;
                            queue.offer(new int[]{x, y});
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    private void dfs(int[][] grid, int i, int j, boolean[][] visited, Queue<int[]> queue) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid.length || grid[i][j] == 0 || visited[i][j]) {
            return;
        }
        visited[i][j] = true;
        queue.offer(new int[]{i, j});
        dfs(grid, i + 1, j, visited, queue);
        dfs(grid, i - 1, j, visited, queue);
        dfs(grid, i, j + 1, visited, queue);
        dfs(grid, i, j - 1, visited, queue);
    }
}