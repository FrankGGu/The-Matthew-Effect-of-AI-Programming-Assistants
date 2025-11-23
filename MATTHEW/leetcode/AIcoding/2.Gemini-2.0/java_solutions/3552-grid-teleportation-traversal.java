import java.util.*;

class Solution {
    public int minCost(int[][] grid, int teleportCost) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        dist[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[2]));
        pq.offer(new int[]{0, 0, 0});

        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int row = curr[0];
            int col = curr[1];
            int cost = curr[2];

            if (cost > dist[row][col]) continue;

            for (int[] dir : dirs) {
                int newRow = row + dir[0];
                int newCol = col + dir[1];

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                    int newCost = cost + 1;
                    if (newCost < dist[newRow][newCol]) {
                        dist[newRow][newCol] = newCost;
                        pq.offer(new int[]{newRow, newCol, newCost});
                    }
                }
            }

            if (grid[row][col] == 1) {
                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {
                        if (i == row && j == col) continue;

                        int newCost = cost + teleportCost;
                        if (newCost < dist[i][j]) {
                            dist[i][j] = newCost;
                            pq.offer(new int[]{i, j, newCost});
                        }
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
}