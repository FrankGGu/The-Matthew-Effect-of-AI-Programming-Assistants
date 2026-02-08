class Solution {
    public boolean hasValidPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        return dfs(grid, 0, 0, visited);
    }

    private boolean dfs(int[][] grid, int row, int col, boolean[][] visited) {
        int m = grid.length;
        int n = grid[0].length;

        if (row < 0 || row >= m || col < 0 || col >= n || visited[row][col]) {
            return false;
        }

        if (row == m - 1 && col == n - 1) {
            return true;
        }

        visited[row][col] = true;
        int street = grid[row][col];

        if (street == 1) {
            if (col + 1 < n && (grid[row][col + 1] == 1 || grid[row][col + 1] == 4 || grid[row][col + 1] == 6) && dfs(grid, row, col + 1, visited)) {
                return true;
            }
            if (col - 1 >= 0 && (grid[row][col - 1] == 1 || grid[row][col - 1] == 3 || grid[row][col - 1] == 5) && dfs(grid, row, col - 1, visited)) {
                return true;
            }
        } else if (street == 2) {
            if (row + 1 < m && (grid[row + 1][col] == 2 || grid[row + 1][col] == 5 || grid[row + 1][col] == 6) && dfs(grid, row + 1, col, visited)) {
                return true;
            }
            if (row - 1 >= 0 && (grid[row - 1][col] == 2 || grid[row - 1][col] == 3 || grid[row - 1][col] == 4) && dfs(grid, row - 1, col, visited)) {
                return true;
            }
        } else if (street == 3) {
            if (col - 1 >= 0 && (grid[row][col - 1] == 1 || grid[row][col - 1] == 3 || grid[row][col - 1] == 5) && dfs(grid, row, col - 1, visited)) {
                return true;
            }
            if (row + 1 < m && (grid[row + 1][col] == 2 || grid[row + 1][col] == 5 || grid[row + 1][col] == 6) && dfs(grid, row + 1, col, visited)) {
                return true;
            }
        } else if (street == 4) {
            if (col + 1 < n && (grid[row][col + 1] == 1 || grid[row][col + 1] == 4 || grid[row][col + 1] == 6) && dfs(grid, row, col + 1, visited)) {
                return true;
            }
            if (row + 1 < m && (grid[row + 1][col] == 2 || grid[row + 1][col] == 5 || grid[row + 1][col] == 6) && dfs(grid, row + 1, col, visited)) {
                return true;
            }
        } else if (street == 5) {
            if (col - 1 >= 0 && (grid[row][col - 1] == 1 || grid[row][col - 1] == 3 || grid[row][col - 1] == 5) && dfs(grid, row, col - 1, visited)) {
                return true;
            }
            if (row - 1 >= 0 && (grid[row - 1][col] == 2 || grid[row - 1][col] == 3 || grid[row - 1][col] == 4) && dfs(grid, row - 1, col, visited)) {
                return true;
            }
        } else {
            if (col + 1 < n && (grid[row][col + 1] == 1 || grid[row][col + 1] == 4 || grid[row][col + 1] == 6) && dfs(grid, row, col + 1, visited)) {
                return true;
            }
            if (row - 1 >= 0 && (grid[row - 1][col] == 2 || grid[row - 1][col] == 3 || grid[row - 1][col] == 4) && dfs(grid, row - 1, col, visited)) {
                return true;
            }
        }

        visited[row][col] = false;
        return false;
    }
}