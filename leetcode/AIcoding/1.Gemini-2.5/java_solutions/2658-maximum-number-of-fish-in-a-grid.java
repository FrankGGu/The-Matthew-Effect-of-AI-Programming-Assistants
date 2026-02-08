class Solution {
    int[][] grid;
    boolean[][] visited;
    int rows;
    int cols;
    int[] dr = {-1, 1, 0, 0};
    int[] dc = {0, 0, -1, 1};

    public int findMaxFish(int[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        this.cols = grid[0].length;
        this.visited = new boolean[rows][cols];
        int maxFish = 0;

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (grid[r][c] > 0 && !visited[r][c]) {
                    maxFish = Math.max(maxFish, dfs(r, c));
                }
            }
        }
        return maxFish;
    }

    private int dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] || grid[r][c] == 0) {
            return 0;
        }

        visited[r][c] = true;
        int currentFish = grid[r][c];

        for (int i = 0; i < 4; i++) {
            currentFish += dfs(r + dr[i], c + dc[i]);
        }
        return currentFish;
    }
}