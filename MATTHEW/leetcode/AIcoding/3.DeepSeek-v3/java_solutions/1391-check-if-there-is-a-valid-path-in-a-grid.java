class Solution {
    private static final int[][][] dirs = {
        {{0, -1}, {0, 1}},
        {{-1, 0}, {1, 0}},
        {{0, -1}, {1, 0}},
        {{0, 1}, {1, 0}},
        {{0, -1}, {-1, 0}},
        {{0, 1}, {-1, 0}}
    };

    public boolean hasValidPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0});
        visited[0][0] = true;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0], y = curr[1];
            if (x == m - 1 && y == n - 1) {
                return true;
            }
            int street = grid[x][y] - 1;
            for (int[] dir : dirs[street]) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                    for (int[] backDir : dirs[grid[nx][ny] - 1]) {
                        if (nx + backDir[0] == x && ny + backDir[1] == y) {
                            visited[nx][ny] = true;
                            queue.offer(new int[]{nx, ny});
                            break;
                        }
                    }
                }
            }
        }
        return false;
    }
}