public class Solution {

import java.util.*;

public class Solution {
    public int minTimeToReachLastRoom(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int[][] time = new int[n][m];
        for (int i = 0; i < n; i++) {
            Arrays.fill(time[i], Integer.MAX_VALUE);
        }
        time[0][0] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, 0, 0});
        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int t = curr[0];
            int i = curr[1];
            int j = curr[2];
            if (i == n - 1 && j == m - 1) {
                return t;
            }
            for (int[] dir : dirs) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < n && nj >= 0 && nj < m) {
                    int newTime = Math.max(t, grid[ni][nj]) + 1;
                    if (newTime < time[ni][nj]) {
                        time[ni][nj] = newTime;
                        pq.offer(new int[]{newTime, ni, nj});
                    }
                }
            }
        }
        return time[n - 1][m - 1];
    }
}
}