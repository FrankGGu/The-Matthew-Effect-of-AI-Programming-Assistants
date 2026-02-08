import java.util.PriorityQueue;
import java.util.Arrays;

class Solution {
    public int minimumEffortPath(int[][] heights) {
        int rows = heights.length;
        int cols = heights[0].length;

        int[][] dist = new int[rows][cols];
        for (int i = 0; i < rows; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        dist[0][0] = 0;
        pq.offer(new int[]{0, 0, 0});

        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentEffort = current[0];
            int r = current[1];
            int c = current[2];

            if (currentEffort > dist[r][c]) {
                continue;
            }

            if (r == rows - 1 && c == cols - 1) {
                return currentEffort;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                    int edgeEffort = Math.abs(heights[r][c] - heights[nr][nc]);
                    int newMaxEffort = Math.max(currentEffort, edgeEffort);

                    if (newMaxEffort < dist[nr][nc]) {
                        dist[nr][nc] = newMaxEffort;
                        pq.offer(new int[]{newMaxEffort, nr, nc});
                    }
                }
            }
        }

        return dist[rows - 1][cols - 1];
    }
}