public class Solution {

import java.util.*;

public class Solution {
    public int minimumObstacleRemovalToReachCorner(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        dist[0][0] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{0, 0, 0});
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0];
            int y = curr[1];
            int d = curr[2];
            if (x == m - 1 && y == n - 1) {
                return d;
            }
            if (d > dist[x][y]) {
                continue;
            }
            for (int[] dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && ny >= 0 && nx < m && ny < n) {
                    int newD = d + grid[nx][ny];
                    if (newD < dist[nx][ny]) {
                        dist[nx][ny] = newD;
                        pq.offer(new int[]{nx, ny, newD});
                    }
                }
            }
        }
        return -1;
    }
}
}