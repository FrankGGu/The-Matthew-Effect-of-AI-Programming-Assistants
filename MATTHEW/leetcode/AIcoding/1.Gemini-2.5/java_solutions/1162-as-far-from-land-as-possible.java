import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int maxDistance(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;

        Queue<int[]> q = new LinkedList<>();
        int landCells = 0;

        // Add all land cells to the queue and count them
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] == 1) {
                    q.offer(new int[]{i, j});
                    landCells++;
                }
            }
        }

        // Edge case: no land cells or all cells are land
        if (landCells == 0 || landCells == n * m) {
            return -1;
        }

        int distance = 0;
        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!q.isEmpty()) {
            int levelSize = q.size();
            boolean moved = false; 

            for (int i = 0; i < levelSize; i++) {
                int[] cell = q.poll();
                int r = cell[0];
                int c = cell[1];

                for (int[] dir : dirs) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    // Check bounds and if it's an unvisited water cell
                    if (nr >= 0 && nr < n && nc >= 0 && nc < m && grid[nr][nc] == 0) {
                        grid[nr][nc] = 1; // Mark as visited (or part of land expansion)
                        q.offer(new int[]{nr, nc});
                        moved = true;
                    }
                }
            }

            // Only increment distance if we actually expanded to new water cells in this level
            if (moved) {
                distance++;
            }
        }

        return distance;
    }
}