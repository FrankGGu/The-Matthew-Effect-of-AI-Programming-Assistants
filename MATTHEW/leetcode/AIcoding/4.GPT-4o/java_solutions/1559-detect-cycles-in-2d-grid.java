class Solution {
    public boolean containsCycle(char[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        boolean[][] visited = new boolean[rows][cols];
        boolean[][] inStack = new boolean[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (!visited[i][j]) {
                    if (dfs(grid, visited, inStack, i, j, -1, -1, grid[i][j])) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private boolean dfs(char[][] grid, boolean[][] visited, boolean[][] inStack, int x, int y, int prevX, int prevY, char ch) {
        visited[x][y] = true;
        inStack[x][y] = true;

        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        for (int[] dir : directions) {
            int newX = x + dir[0];
            int newY = y + dir[1];
            if (newX >= 0 && newX < grid.length && newY >= 0 && newY < grid[0].length) {
                if (grid[newX][newY] == ch) {
                    if (!visited[newX][newY]) {
                        if (dfs(grid, visited, inStack, newX, newY, x, y, ch)) {
                            return true;
                        }
                    } else if (inStack[newX][newY] && (newX != prevX || newY != prevY)) {
                        return true;
                    }
                }
            }
        }

        inStack[x][y] = false;
        return false;
    }
}