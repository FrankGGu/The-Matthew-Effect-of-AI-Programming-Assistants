public class Solution {

import java.util.*;

public class Solution {
    public int possibleDay;
    public int[][] grid;
    public int rows;
    public int cols;

    public int earliestDayToCross(int[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        this.cols = grid[0].length;
        int left = 1, right = rows * cols;
        int answer = right;

        while (left <= right) {
            int mid = (left + right) / 2;
            if (canCross(mid)) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return answer;
    }

    private boolean canCross(int day) {
        boolean[][] visited = new boolean[rows][cols];
        Queue<int[]> queue = new LinkedList<>();

        for (int j = 0; j < cols; j++) {
            if (grid[0][j] <= day) {
                queue.add(new int[]{0, j});
                visited[0][j] = true;
            }
        }

        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

        while (!queue.isEmpty()) {
            int[] cell = queue.poll();
            int r = cell[0], c = cell[1];

            if (r == rows - 1) {
                return true;
            }

            for (int[] dir : directions) {
                int nr = r + dir[0], nc = c + dir[1];
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc] && grid[nr][nc] <= day) {
                    visited[nr][nc] = true;
                    queue.add(new int[]{nr, nc});
                }
            }
        }

        return false;
    }

    public int latestDayToCross(int[][] grid) {
        return earliestDayToCross(grid);
    }
}
}