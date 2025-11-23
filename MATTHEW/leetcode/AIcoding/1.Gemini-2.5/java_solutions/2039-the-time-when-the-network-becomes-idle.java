import java.util.*;

class Solution {
    public int networkBecomesIdle(int n, int[][] edges, int[] patience) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] dist = new int[n];
        Arrays.fill(dist, -1);

        Queue<Integer> q = new LinkedList<>();

        dist[0] = 0;
        q.offer(0);

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.offer(v);
                }
            }
        }

        int maxIdleTime = 0;

        for (int i = 1; i < n; i++) {
            int travelTime = dist[i];
            int roundTripTime = 2 * travelTime;

            int currentServerIdleTime;
            if (roundTripTime <= patience[i]) {
                currentServerIdleTime = roundTripTime;
            } else {
                int numRetransmissions = (roundTripTime - 1) / patience[i];
                int lastSendTime = numRetransmissions * patience[i];

                currentServerIdleTime = lastSendTime + roundTripTime;
            }
            maxIdleTime = Math.max(maxIdleTime, currentServerIdleTime);
        }

        return maxIdleTime;
    }
}