import java.util.PriorityQueue;

class Solution {
    public int minimumTime(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        if (grid[0][1] > 1 && grid[1][0] > 1) {
            return -1;
        }

        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dist[i][j] = Integer.MAX_VALUE;
            }
        }
        dist[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, 0, 0});

        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int time = curr[0];
            int row = curr[1];
            int col = curr[2];

            if (time > dist[row][col]) {
                continue;
            }

            if (row == m - 1 && col == n - 1) {
                return time;
            }

            for (int[] dir : dirs) {
                int newRow = row + dir[0];
                int newCol = col + dir[1];

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                    int waitTime = grid[newRow][newCol] - time - 1;
                    int newTime = Math.max(time + 1, grid[newRow][newCol] + (waitTime > 0 ? (waitTime % 2 == 0 ? 0 : 1) : 0) );

                    if (newTime < dist[newRow][newCol]) {
                        dist[newRow][newCol] = newTime;
                        pq.offer(new int[]{newTime, newRow, newCol});
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
}