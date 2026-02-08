class Solution {
    private int m, n;
    private int[][] grid;
    private boolean[][] visited;
    private int maxGold = 0;
    private int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int getMaximumGold(int[][] grid) {
        this.grid = grid;
        this.m = grid.length;
        this.n = grid[0].length;
        this.visited = new boolean[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] != 0) {
                    dfs(i, j, 0);
                }
            }
        }

        return maxGold;
    }

    private void dfs(int row, int col, int currentGold) {
        if (row < 0 || row >= m || col < 0 || col >= n || grid[row][col] == 0 || visited[row][col]) {
            maxGold = Math.max(maxGold, currentGold);
            return;
        }

        visited[row][col] = true;
        int gold = grid[row][col];
        currentGold += gold;

        for (int[] direction : directions) {
            int newRow = row + direction[0];
            int newCol = col + direction[1];
            dfs(newRow, newCol, currentGold);
        }

        visited[row][col] = false;
    }
}