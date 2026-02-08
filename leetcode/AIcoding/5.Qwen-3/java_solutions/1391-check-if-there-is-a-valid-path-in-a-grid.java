public class Solution {

import java.util.*;

public class Solution {
    public boolean hasValidPath(char[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[][] directions = new int[][]{{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int[][] type = new int[][]{
            {-1, -1, 0, 1},
            {-1, -1, 3, 2},
            {-1, 2, -1, 0},
            {1, 0, -1, -1}
        };
        boolean[][] visited = new boolean[rows][cols];
        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{0, 0});
        visited[0][0] = true;
        int[][] gridType = new int[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                switch (grid[i][j]) {
                    case 'L': gridType[i][j] = 0; break;
                    case 'R': gridType[i][j] = 1; break;
                    case 'D': gridType[i][j] = 2; break;
                    case 'U': gridType[i][j] = 3; break;
                }
            }
        }
        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];
            if (r == rows - 1 && c == cols - 1) return true;
            int currentType = gridType[r][c];
            for (int d = 0; d < 4; d++) {
                int nr = r + directions[d][0];
                int nc = c + directions[d][1];
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc]) {
                    int neighborType = gridType[nr][nc];
                    if (type[currentType][d] == neighborType) {
                        visited[nr][nc] = true;
                        queue.add(new int[]{nr, nc});
                    }
                }
            }
        }
        return false;
    }
}
}