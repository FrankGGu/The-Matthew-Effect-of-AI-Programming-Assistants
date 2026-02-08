public class Solution {

import java.util.*;

public class Solution {
    public int[][] colorBorder(int[][] grid, int rStart, int cStart, int color) {
        int rows = grid.length;
        int cols = grid[0].length;
        boolean[][] visited = new boolean[rows][cols];
        Queue<int[]> queue = new LinkedList<>();
        int originalColor = grid[rStart][cStart];
        queue.add(new int[]{rStart, cStart});
        visited[rStart][cStart] = true;
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        List<int[]> borders = new ArrayList<>();

        while (!queue.isEmpty()) {
            int[] cell = queue.poll();
            int r = cell[0];
            int c = cell[1];
            int count = 0;
            for (int[] dir : directions) {
                int nr = r + dir[0];
                int nc = c + dir[1];
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == originalColor) {
                    count++;
                    if (!visited[nr][nc]) {
                        visited[nr][nc] = true;
                        queue.add(new int[]{nr, nc});
                    }
                }
            }
            if (count < 4) {
                borders.add(new int[]{r, c});
            }
        }

        for (int[] border : borders) {
            int r = border[0];
            int c = border[1];
            grid[r][c] = color;
        }

        return grid;
    }
}
}