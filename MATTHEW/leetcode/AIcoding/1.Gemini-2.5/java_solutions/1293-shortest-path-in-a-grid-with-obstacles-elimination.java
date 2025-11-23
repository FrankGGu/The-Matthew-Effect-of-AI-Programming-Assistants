import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int shortestPath(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;

        // State: {row, col, obstacles_eliminated_so_far, steps}
        Queue<int[]> q = new LinkedList<>();

        // visited[r][c][elim_count] stores true if state (r, c, elim_count) has been visited.
        // elim_count can range from 0 to k. So size k+1.
        boolean[][][] visited = new boolean[m][n][k + 1];

        // Initial state: (0, 0)
        // If grid[0][0] is an obstacle, we must use 1 k to be on it.
        // If k is 0 and grid[0][0] is 1, it's impossible.
        if (grid[0][0] == 1) {
            if (k == 0) {
                return -1; // Cannot start if (0,0) is obstacle and k=0
            }
            q.offer(new int[]{0, 0, 1, 0}); // Initial elim_used = 1
            visited[0][0][1] = true;
        } else {
            q.offer(new int[]{0, 0, 0, 0}); // Initial elim_used = 0
            visited[0][0][0] = true;
        }

        int[] dr = {-1, 1, 0, 0}; // Up, Down
        int[] dc = {0, 0, -1, 1}; // Left, Right

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];
            int elim = curr[2];
            int steps = curr[3];

            // If target reached
            if (r == m - 1 && c == n - 1) {
                return steps;
            }

            // Explore neighbors
            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check bounds
                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    int newElim = elim + grid[nr][nc];

                    // If newElim is within k limit and not visited
                    if (newElim <= k && !visited[nr][nc][newElim]) {
                        visited[nr][nc][newElim] = true;
                        q.offer(new int[]{nr, nc, newElim, steps + 1});
                    }
                }
            }
        }

        // If queue becomes empty and target not reached
        return -1;
    }
}