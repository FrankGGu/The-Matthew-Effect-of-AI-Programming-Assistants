public class Solution {
    public boolean isPossible(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int startRow = -1, startCol = -1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    startRow = i;
                    startCol = j;
                    break;
                }
            }
            if (startRow != -1) break;
        }

        if (startRow == -1) return true;

        boolean[][] visited = new boolean[m][n];
        boolean[] found = new boolean[1];
        dfs(grid, visited, startRow, startCol, m, n, found);

        if (!found[0]) return true;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    boolean[][] visited2 = new boolean[m][n];
                    boolean[] found2 = new boolean[1];
                    dfs(grid, visited2, startRow, startCol, m, n, found2);
                    if (!found2[0]) {
                        return true;
                    }
                    grid[i][j] = 1;
                }
            }
        }

        return false;
    }

    private void dfs(int[][] grid, boolean[][] visited, int i, int j, int m, int n, boolean[] found) {
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || grid[i][j] == 0) {
            return;
        }

        visited[i][j] = true;

        if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
            found[0] = true;
            return;
        }

        dfs(grid, visited, i + 1, j, m, n, found);
        dfs(grid, visited, i - 1, j, m, n, found);
        dfs(grid, visited, i, j + 1, m, n, found);
        dfs(grid, visited, i, j - 1, m, n, found);
    }
}