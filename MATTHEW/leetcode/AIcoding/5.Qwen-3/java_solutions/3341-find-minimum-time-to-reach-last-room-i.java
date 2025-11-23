public class Solution {

import java.util.*;

public class Solution {
    public int minTimeToReachLastRoom(List<List<Integer>> roomTimes) {
        int m = roomTimes.size();
        int n = roomTimes.get(0).size();
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{roomTimes.get(0).get(0), 0, 0});
        dist[0][0] = roomTimes.get(0).get(0);

        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int time = curr[0];
            int x = curr[1];
            int y = curr[2];

            if (x == m - 1 && y == n - 1) {
                return time;
            }

            for (int[] dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int newTime = Math.max(time, roomTimes.get(nx).get(ny));
                    if (newTime < dist[nx][ny]) {
                        dist[nx][ny] = newTime;
                        pq.offer(new int[]{newTime, nx, ny});
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
}
}