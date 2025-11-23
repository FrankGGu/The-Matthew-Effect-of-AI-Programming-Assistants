class Solution {
    public boolean isSafe(int[][] grid, int x, int y) {
        return x >= 0 && x < grid.length && y >= 0 && y < grid[0].length && grid[x][y] == 0;
    }

    public boolean dfs(int[][] grid, int x, int y, boolean[][] visited) {
        if (x == grid.length - 1 && y == grid[0].length - 1) {
            return true;
        }

        visited[x][y] = true;

        int[] dx = {0, 1, 0, -1};
        int[] dy = {1, 0, -1, 0};

        for (int i = 0; i < 4; i++) {
            int newX = x + dx[i];
            int newY = y + dy[i];

            if (isSafe(grid, newX, newY) && !visited[newX][newY]) {
                if (dfs(grid, newX, newY, visited)) {
                    return true;
                }
            }
        }

        visited[x][y] = false;
        return false;
    }

    public boolean canWalk(int[][] grid) {
        boolean[][] visited = new boolean[grid.length][grid[0].length];
        return dfs(grid, 0, 0, visited);
    }
}