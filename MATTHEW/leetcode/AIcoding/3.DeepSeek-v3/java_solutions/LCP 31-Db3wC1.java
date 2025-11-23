class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public boolean escapeMaze(List<List<String>> maze) {
        int T = maze.size();
        int m = maze.get(0).size();
        int n = maze.get(0).get(0).length();
        boolean[][][][][] visited = new boolean[m][n][T][2][2];
        return dfs(maze, 0, 0, 0, 0, 0, visited, m, n, T);
    }

    private boolean dfs(List<List<String>> maze, int x, int y, int t, int temp, int perm, boolean[][][][][] visited, int m, int n, int T) {
        if (x == m - 1 && y == n - 1) {
            return true;
        }
        if (t == T - 1) {
            return false;
        }
        if (visited[x][y][t][temp][perm]) {
            return false;
        }
        visited[x][y][t][temp][perm] = true;
        for (int[] dir : dirs) {
            int nx = x + dir[0];
            int ny = y + dir[1];
            if (nx < 0 || nx >= m || ny < 0 || ny >= n) {
                continue;
            }
            char c = maze.get(t + 1).get(nx).charAt(ny);
            if (c == '.') {
                if (dfs(maze, nx, ny, t + 1, temp, perm, visited, m, n, T)) {
                    return true;
                }
            } else {
                if (temp == 0 && dfs(maze, nx, ny, t + 1, 1, perm, visited, m, n, T)) {
                    return true;
                }
                if (perm == 0 && dfs(maze, nx, ny, t + 1, temp, 1, visited, m, n, T)) {
                    return true;
                }
            }
        }
        return dfs(maze, x, y, t + 1, temp, perm, visited, m, n, T);
    }
}