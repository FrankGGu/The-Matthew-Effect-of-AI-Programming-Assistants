import java.util.PriorityQueue;
import java.util.Arrays;

class Solution {
    public int findMinimumTime(int[][] rooms) {
        int m = rooms.length;
        if (m == 0) {
            return -1; 
        }
        int n = rooms[0].length;
        if (n == 0) {
            return -1;
        }

        int[][] dist = new int[m][n];
        for (int[] row : dist) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        dist[0][0] = rooms[0][0];
        pq.offer(new int[]{dist[0][0], 0, 0});

        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentTime = current[0];
            int r = current[1];
            int c = current[2];

            if (currentTime > dist[r][c]) {
                continue;
            }

            if (r == m - 1 && c == n - 1) {
                return currentTime;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    int newTime = currentTime + rooms[nr][nc];

                    if (newTime < dist[nr][nc]) {
                        dist[nr][nc] = newTime;
                        pq.offer(new int[]{newTime, nr, nc});
                    }
                }
            }
        }

        return -1;
    }
}