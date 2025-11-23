import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int orangesRotting(int[][] grid) {
        int m = grid.length;
        int n = grid[0.length];

        Queue<int[]> queue = new LinkedList<>();
        int freshOranges = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    freshOranges++;
                } else if (grid[i][j] == 2) {
                    queue.offer(new int[]{i, j, 0});
                }
            }
        }

        if (freshOranges == 0) {
            return 0;
        }

        int maxTime = 0;
        int rottenCount = 0;
        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];
            int time = current[2];

            maxTime = Math.max(maxTime, time);

            for (int[] dir : directions) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] == 1) {
                    grid[nr][nc] = 2; // Mark as rotten
                    freshOranges--;
                    queue.offer(new int[]{nr, nc, time + 1});
                }
            }
        }

        if (freshOranges == 0) {
            return maxTime;
        } else {
            return -1;
        }
    }
}