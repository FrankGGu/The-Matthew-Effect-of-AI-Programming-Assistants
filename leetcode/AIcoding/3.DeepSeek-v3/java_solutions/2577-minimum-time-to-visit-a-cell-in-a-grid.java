class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int minimumTime(int[][] grid) {
        if (grid[0][1] > 1 && grid[1][0] > 1) {
            return -1;
        }
        int m = grid.length, n = grid[0].length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        boolean[][] visited = new boolean[m][n];
        pq.offer(new int[]{0, 0, 0});
        visited[0][0] = true;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int i = curr[0], j = curr[1], time = curr[2];
            if (i == m - 1 && j == n - 1) {
                return time;
            }
            for (int[] dir : dirs) {
                int x = i + dir[0], y = j + dir[1];
                if (x < 0 || x >= m || y < 0 || y >= n || visited[x][y]) {
                    continue;
                }
                if (grid[x][y] <= time + 1) {
                    visited[x][y] = true;
                    pq.offer(new int[]{x, y, time + 1});
                } else {
                    int diff = grid[x][y] - time;
                    if (diff % 2 == 0) {
                        pq.offer(new int[]{x, y, grid[x][y] + 1});
                    } else {
                        pq.offer(new int[]{x, y, grid[x][y]});
                    }
                }
            }
        }
        return -1;
    }
}