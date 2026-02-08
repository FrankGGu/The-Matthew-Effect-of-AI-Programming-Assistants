public class Solution {
    public int countUnguarded(int m, int n, int[][] guards, int[][] walls) {
        int[][] grid = new int[m][n];
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        for (int[] guard : guards) {
            int x = guard[0], y = guard[1];
            grid[x][y] = 2;
        }

        for (int[] wall : walls) {
            int x = wall[0], y = wall[1];
            grid[x][y] = 3;
        }

        for (int[] guard : guards) {
            int x = guard[0], y = guard[1];
            for (int[] dir : directions) {
                int dx = dir[0], dy = dir[1];
                int nx = x + dx, ny = y + dy;
                while (nx >= 0 && ny >= 0 && nx < m && ny < n && grid[nx][ny] != 2 && grid[nx][ny] != 3) {
                    grid[nx][ny] = 1;
                    nx += dx;
                    ny += dy;
                }
            }
        }

        int count = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    count++;
                }
            }
        }

        return count;
    }
}