import java.util.PriorityQueue;

class Solution {
    public int swimInRisingWater(int[][] grid) {
        int n = grid.length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        boolean[][] visited = new boolean[n][n];

        pq.offer(new int[]{grid[0][0], 0, 0});
        visited[0][0] = true;

        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentMaxElevation = current[0];
            int r = current[1];
            int c = current[2];

            if (r == n - 1 && c == n - 1) {
                return currentMaxElevation;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < n && nc >= 0 && nc < n && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    int newMaxElevation = Math.max(currentMaxElevation, grid[nr][nc]);
                    pq.offer(new int[]{newMaxElevation, nr, nc});
                }
            }
        }
        return -1; // Should not be reached if a path always exists
    }
}