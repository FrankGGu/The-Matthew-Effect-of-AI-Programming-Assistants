import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Arrays;

class Solution {
    public int minCost(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }

        Deque<int[]> deque = new ArrayDeque<>();

        dist[0][0] = 0;
        deque.addFirst(new int[]{0, 0});

        int[] dr = {0, 0, 1, -1}; // 1:right, 2:left, 3:down, 4:up
        int[] dc = {1, -1, 0, 0};

        while (!deque.isEmpty()) {
            int[] curr = deque.removeFirst();
            int r = curr[0];
            int c = curr[1];

            if (r == m - 1 && c == n - 1) {
                return dist[r][c];
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    int cost = (grid[r][c] - 1 == i) ? 0 : 1;

                    if (dist[r][c] + cost < dist[nr][nc]) {
                        dist[nr][nc] = dist[r][c] + cost;
                        if (cost == 0) {
                            deque.addFirst(new int[]{nr, nc});
                        } else {
                            deque.addLast(new int[]{nr, nc});
                        }
                    }
                }
            }
        }
        return dist[m - 1][n - 1]; // Should be reached by the return inside the loop
    }
}