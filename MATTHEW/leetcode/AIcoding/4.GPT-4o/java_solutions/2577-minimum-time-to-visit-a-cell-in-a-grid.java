import java.util.*;

class Solution {
    public int minimumTime(int[][] grid) {
        int n = grid.length, m = grid[0].length;
        int[][] time = new int[n][m];
        for (int[] row : time) Arrays.fill(row, Integer.MAX_VALUE);

        time[0][0] = 0;
        Queue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{0, 0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0], y = curr[1], t = curr[2];

            if (x == n - 1 && y == m - 1) return t;
            if (t > time[x][y]) continue;

            for (int[] dir : new int[][]{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && ny >= 0 && nx < n && ny < m) {
                    int waitTime = Math.max(0, (t + 1) % grid[nx][ny]);
                    int nextTime = t + waitTime + 1;
                    if (nextTime < time[nx][ny]) {
                        time[nx][ny] = nextTime;
                        pq.offer(new int[]{nx, ny, nextTime});
                    }
                }
            }
        }

        return -1;
    }
}