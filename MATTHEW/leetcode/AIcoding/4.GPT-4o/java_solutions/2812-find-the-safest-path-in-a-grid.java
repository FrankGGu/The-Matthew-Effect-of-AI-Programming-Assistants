import java.util.*;

public class Solution {
    public int safestPath(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dangerLevel = new int[m][n];
        for (int[] row : dangerLevel) Arrays.fill(row, Integer.MAX_VALUE);
        dangerLevel[0][0] = grid[0][0];

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[] {0, 0, grid[0][0]});

        int[][] directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0], y = curr[1], currDanger = curr[2];

            for (int[] dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int nextDanger = Math.max(currDanger, grid[nx][ny]);
                    if (nextDanger < dangerLevel[nx][ny]) {
                        dangerLevel[nx][ny] = nextDanger;
                        pq.offer(new int[] {nx, ny, nextDanger});
                    }
                }
            }
        }
        return dangerLevel[m - 1][n - 1];
    }
}