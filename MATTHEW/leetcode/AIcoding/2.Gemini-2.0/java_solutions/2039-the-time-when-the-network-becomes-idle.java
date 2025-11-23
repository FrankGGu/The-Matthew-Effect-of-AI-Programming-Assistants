import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.Queue;

class Solution {
    public int networkBecomesIdle(int[][] edges, int[] patience) {
        int n = patience.length;
        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        dist[0] = 0;

        Queue<Integer> q = new ArrayDeque<>();
        q.offer(0);

        int[][] adj = new int[n][n];
        for (int[] edge : edges) {
            adj[edge[0]][edge[1]] = 1;
            adj[edge[1]][edge[0]] = 1;
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v = 0; v < n; v++) {
                if (adj[u][v] == 1 && dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.offer(v);
                }
            }
        }

        int maxTime = 0;
        for (int i = 1; i < n; i++) {
            int travelTime = 2 * dist[i];
            int lastSendTime = (travelTime / patience[i]) * patience[i];
            if (travelTime % patience[i] == 0 && travelTime > 0) {
                lastSendTime -= patience[i];
            }
            int returnTime = travelTime;
            int idleTime = lastSendTime + returnTime + 1;
            maxTime = Math.max(maxTime, idleTime);
        }

        return maxTime;
    }
}