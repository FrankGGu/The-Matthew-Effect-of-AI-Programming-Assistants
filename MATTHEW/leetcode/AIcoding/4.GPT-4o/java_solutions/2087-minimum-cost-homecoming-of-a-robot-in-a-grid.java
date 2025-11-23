class Solution {
    public int minCost(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] cost = new int[m][n];
        for (int[] row : cost) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        cost[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{0, 0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0], y = curr[1], c = curr[2];

            if (c > cost[x][y]) continue;

            for (int d = 1; d <= 4; d++) {
                int nx = x + (d == 1 ? 0 : d == 2 ? 0 : d == 3 ? -1 : 1);
                int ny = y + (d == 1 ? -1 : d == 2 ? 1 : d == 3 ? 0 : 0);

                if (nx >= 0 && ny >= 0 && nx < m && ny < n) {
                    int newCost = c + (grid[x][y] != d ? 1 : 0);
                    if (newCost < cost[nx][ny]) {
                        cost[nx][ny] = newCost;
                        pq.offer(new int[]{nx, ny, newCost});
                    }
                }
            }
        }
        return cost[m - 1][n - 1];
    }
}