public class Solution {

import java.util.*;

public class Solution {
    int[][] grid;
    int rows, cols;
    int[] dx = {0, 1, 0, -1};
    int[] dy = {1, 0, -1, 0};

    public int minDays(int[][] grid) {
        this.grid = grid;
        rows = grid.length;
        cols = grid[0].length;

        if (countIslands() != 1) return 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    if (countIslands() != 1) {
                        return 1;
                    }
                    grid[i][j] = 1;
                }
            }
        }

        return 2;
    }

    private int countIslands() {
        boolean[][] visited = new boolean[rows][cols];
        int count = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    dfs(i, j, visited);
                    count++;
                }
            }
        }

        return count;
    }

    private void dfs(int i, int j, boolean[][] visited) {
        if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] == 0 || visited[i][j]) {
            return;
        }

        visited[i][j] = true;

        for (int k = 0; k < 4; k++) {
            dfs(i + dx[k], j + dy[k], visited);
        }
    }
}
}