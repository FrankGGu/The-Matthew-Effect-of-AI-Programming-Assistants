import java.util.Arrays;

public class Solution {
    public int networkBecomesIdle(int[][] edges, int[] patience) {
        int n = patience.length;
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            dist[v] = Math.min(dist[v], dist[u] + 1);
            dist[u] = Math.min(dist[u], dist[v] + 1);
        }

        int maxTime = 0;
        for (int i = 1; i < n; i++) {
            int roundTrip = dist[i] * 2;
            int waitTime = (roundTrip - 1) / patience[i] * patience[i];
            maxTime = Math.max(maxTime, roundTrip + waitTime);
        }

        return maxTime + 1;
    }
}