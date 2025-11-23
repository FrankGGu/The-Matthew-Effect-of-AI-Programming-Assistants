import java.util.PriorityQueue;

public class Solution {
    public int minCost(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] cost = new int[m][n];
        for (int[] row : cost) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        cost[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{0, 0, 0});

        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0], y = curr[1], c = curr[2];
            if (x == m - 1 && y == n - 1) {
                return c;
            }
            for (int i = 0; i < 4; i++) {
                int newX = x + directions[i][0];
                int newY = y + directions[i][1];
                if (newX >= 0 && newX < m && newY >= 0 && newY < n) {
                    int newCost = c + (i + 1 != grid[x][y] ? 1 : 0);
                    if (newCost < cost[newX][newY]) {
                        cost[newX][newY] = newCost;
                        pq.offer(new int[]{newX, newY, newCost});
                    }
                }
            }
        }
        return -1;
    }
}