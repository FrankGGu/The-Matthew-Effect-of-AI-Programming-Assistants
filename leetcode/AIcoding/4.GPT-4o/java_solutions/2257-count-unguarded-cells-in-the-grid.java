class Solution {
    public int countUnguarded(int m, int n, int[][] guards, int[][] walls) {
        boolean[][] grid = new boolean[m][n];

        for (int[] wall : walls) {
            grid[wall[0]][wall[1]] = true;
        }

        for (int[] guard : guards) {
            grid[guard[0]][guard[1]] = true;
            markUnguarded(grid, guard[0], guard[1], m, n);
        }

        int count = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (!grid[i][j]) {
                    count++;
                }
            }
        }

        return count;
    }

    private void markUnguarded(boolean[][] grid, int x, int y, int m, int n) {
        for (int i = x + 1; i < m && !grid[i][y]; i++) {
            grid[i][y] = true;
        }
        for (int i = x - 1; i >= 0 && !grid[i][y]; i--) {
            grid[i][y] = true;
        }
        for (int j = y + 1; j < n && !grid[x][j]; j++) {
            grid[x][j] = true;
        }
        for (int j = y - 1; j >= 0 && !grid[x][j]; j--) {
            grid[x][j] = true;
        }
    }
}