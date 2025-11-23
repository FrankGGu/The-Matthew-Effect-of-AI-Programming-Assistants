public class Solution {

import java.util.*;

class Solution {
    public int findMinimumTime(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        if (grid[0][0] > 0) return -1;

        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        dist[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, 0, 0});

        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int time = curr[0];
            int x = curr[1];
            int y = curr[2];

            if (x == m - 1 && y == n - 1) return time;

            if (time > dist[x][y]) continue;

            for (int[] dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int newTime = Math.max(time + 1, grid[nx][ny]);
                    if (newTime < dist[nx][ny]) {
                        dist[nx][ny] = newTime;
                        pq.offer(new int[]{newTime, nx, ny});
                    }
                }
            }
        }

        return -1;
    }
}
}