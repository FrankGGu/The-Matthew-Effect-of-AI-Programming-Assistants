import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int solve(int[][] grid) {
        if (grid == null || grid.length == 0 || grid[0].length == 0) {
            return 0;
        }

        int rows = grid.length;
        int cols = grid[0].length;
        Queue<int[]> queue = new LinkedList<>();
        int sandCells = 0;

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (grid[r][c] == 1) {
                    queue.offer(new int[]{r, c});
                } else {
                    sandCells++;
                }
            }
        }

        if (sandCells == 0) {
            return 0;
        }

        if (queue.isEmpty()) { 
            return -1;
        }

        int time = -1; 

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            for (int i = 0; i < levelSize; i++) {
                int[] cell = queue.poll();
                int r = cell[0];
                int c = cell[1];

                for (int[] dir : directions) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == 0) {
                        grid[nr][nc] = 1; 
                        sandCells--;
                        queue.offer(new int[]{nr, nc});
                    }
                }
            }
            time++; 
        }

        return sandCells == 0 ? time : -1;
    }
}