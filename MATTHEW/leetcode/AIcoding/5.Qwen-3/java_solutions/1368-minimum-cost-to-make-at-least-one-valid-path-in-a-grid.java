public class Solution {

import java.util.*;

public class Solution {
    public int minCost(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, 0, 0});
        dist[0][0] = 0;
        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int cost = curr[0];
            int x = curr[1];
            int y = curr[2];
            if (x == m - 1 && y == n - 1) {
                return cost;
            }
            if (cost > dist[x][y]) {
                continue;
            }
            for (int i = 0; i < 4; i++) {
                int nx = x + dirs[i][0];
                int ny = y + dirs[i][1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int newCost = cost + (grid[x][y] == i + 1 ? 0 : 1);
                    if (newCost < dist[nx][ny]) {
                        dist[nx][ny] = newCost;
                        pq.offer(new int[]{newCost, nx, ny});
                    }
                }
            }
        }
        return dist[m - 1][n - 1];
    }
}
}