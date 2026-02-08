import java.util.ArrayList;
import java.util.List;

class Solution {

    private int[] dr = {-1, 1, 0, 0};
    private int[] dc = {0, 0, -1, 1};

    public int[][] colorBorder(int[][] grid, int r0, int c0, int color) {
        int rows = grid.length;
        int cols = grid[0].length;
        int originalColor = grid[r0][c0];

        boolean[][] visited = new boolean[rows][cols];
        List<int[]> borderCells = new ArrayList<>();

        dfs(grid, r0, c0, rows, cols, originalColor, visited, borderCells);

        for (int[] cell : borderCells) {
            grid[cell[0]][cell[1]] = color;
        }

        return grid;
    }

    private void dfs(int[][] grid, int r, int c, int rows, int cols, int originalColor, boolean[][] visited, List<int[]> borderCells) {
        if (r < 0 || r >= rows || c < 0 || c >= cols) {
            return;
        }
        if (grid[r][c] != originalColor) {
            return;
        }
        if (visited[r][c]) {
            return;
        }

        visited[r][c] = true;

        int sameColorNeighbors = 0;
        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == originalColor) {
                sameColorNeighbors++;
            }
        }

        if (sameColorNeighbors < 4) {
            borderCells.add(new int[]{r, c});
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            dfs(grid, nr, nc, rows, cols, originalColor, visited, borderCells);
        }
    }
}