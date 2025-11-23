import java.util.PriorityQueue;

class Solution {
    public int minimumObstacles(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dist = new int[m][n];
        for (int[] row : dist) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dist[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{0, 0, 0});

        int[][] directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0], y = curr[1], cost = curr[2];

            if (x == m - 1 && y == n - 1) {
                return cost;
            }

            for (int[] dir : directions) {
                int newX = x + dir[0], newY = y + dir[1];
                if (newX >= 0 && newX < m && newY >= 0 && newY < n) {
                    int newCost = cost + grid[newX][newY];
                    if (newCost < dist[newX][newY]) {
                        dist[newX][newY] = newCost;
                        pq.offer(new int[]{newX, newY, newCost});
                    }
                }
            }
        }

        return -1;
    }
}