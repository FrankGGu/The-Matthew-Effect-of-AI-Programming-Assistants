class Solution {
    private int[][] grid;
    private int rows, cols;
    private int[] dx = {0, 0, 1, -1};
    private int[] dy = {1, -1, 0, 0};

    public int minDays(int[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        this.cols = grid[0].length;

        if (countIslands() != 1) {
            return 0;
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    if (countIslands() != 1) {
                        return 1;
                    }
                    grid[i][j] = 1;
                }
            }
        }

        return 2;
    }

    private int countIslands() {
        int count = 0;
        boolean[][] visited = new boolean[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    dfs(i, j, visited);
                    count++;
                }
            }
        }
        return count;
    }

    private void dfs(int i, int j, boolean[][] visited) {
        visited[i][j] = true;
        for (int k = 0; k < 4; k++) {
            int x = i + dx[k];
            int y = j + dy[k];
            if (x >= 0 && x < rows && y >= 0 && y < cols && grid[x][y] == 1 && !visited[x][y]) {
                dfs(x, y, visited);
            }
        }
    }
}