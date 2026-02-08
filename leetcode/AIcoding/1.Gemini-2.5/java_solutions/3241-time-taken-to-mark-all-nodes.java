import java.util.*;

class Solution {
    public int timeTakenToMarkAllNodes(int n, int[][] edges, int[] time, int startNode) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        dist[startNode] = time[startNode];
        pq.offer(new int[]{time[startNode], startNode});

        int maxTime = 0;

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentTime = current[0];
            int u = current[1];

            if (currentTime > dist[u]) {
                continue;
            }

            maxTime = Math.max(maxTime, currentTime);

            for (int v : adj.get(u)) {
                int newTimeForV = currentTime + time[v];

                if (newTimeForV < dist[v]) {
                    dist[v] = newTimeForV;
                    pq.offer(new int[]{newTimeForV, v});
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (dist[i] == Integer.MAX_VALUE) {
                return -1;
            }
        }

        return maxTime;
    }
}