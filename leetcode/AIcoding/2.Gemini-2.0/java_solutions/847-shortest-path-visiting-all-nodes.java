import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int shortestPathLength(int[][] graph) {
        int n = graph.length;
        if (n == 1) return 0;

        int target = (1 << n) - 1;
        Queue<int[]> queue = new LinkedList<>();
        int[][] dist = new int[n][1 << n];

        for (int i = 0; i < n; i++) {
            queue.offer(new int[]{i, 1 << i});
            dist[i][1 << i] = 0;
        }

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int node = curr[0];
            int mask = curr[1];
            int d = dist[node][mask];

            for (int neighbor : graph[node]) {
                int newMask = mask | (1 << neighbor);
                if (dist[neighbor][newMask] == 0) {
                    dist[neighbor][newMask] = d + 1;
                    queue.offer(new int[]{neighbor, newMask});
                } else if (dist[neighbor][newMask] > d + 1) {
                    dist[neighbor][newMask] = d + 1;
                    queue.offer(new int[]{neighbor, newMask});
                }
            }
        }

        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (dist[i][target] > 0) {
                ans = Math.min(ans, dist[i][target]);
            }
        }

        return ans;
    }
}