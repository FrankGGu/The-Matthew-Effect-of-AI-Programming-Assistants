class Solution {
    public int minimumTime(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] time = new int[m][n];
        for (int[] row : time) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        time[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[] {0, 0, 0});

        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0], y = curr[1], t = curr[2];

            if (x == m - 1 && y == n - 1) {
                return t;
            }

            for (int[] dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int waitTime = (t % (grid[nx][ny] + 1) == 0) ? 0 : (grid[nx][ny] + 1 - t % (grid[nx][ny] + 1));
                    int newTime = t + waitTime + 1;
                    if (newTime < time[nx][ny]) {
                        time[nx][ny] = newTime;
                        pq.offer(new int[] {nx, ny, newTime});
                    }
                }
            }
        }

        return -1;
    }
}