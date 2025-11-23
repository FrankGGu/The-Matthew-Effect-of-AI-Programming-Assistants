import java.util.Deque;
import java.util.LinkedList;
import java.util.Arrays;

class Solution {
    public int minimumObstacles(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int[][] dist = new int[m][n];
        for (int[] row : dist) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }

        Deque<int[]> deque = new LinkedList<>();

        dist[0][0] = 0;
        deque.addFirst(new int[]{0, 0, 0}); // {row, col, cost}

        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        while (!deque.isEmpty()) {
            int[] current = deque.removeFirst();
            int r = current[0];
            int c = current[1];
            int d = current[2];

            if (r == m - 1 && c == n - 1) {
                return d;
            }

            if (d > dist[r][c]) {
                continue;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    int newCost = d + grid[nr][nc];

                    if (newCost < dist[nr][nc]) {
                        dist[nr][nc] = newCost;
                        if (grid[nr][nc] == 0) {
                            deque.addFirst(new int[]{nr, nc, newCost});
                        } else {
                            deque.addLast(new int[]{nr, nc, newCost});
                        }
                    }
                }
            }
        }
        return -1; 
    }
}