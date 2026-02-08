import java.util.*;

class Solution {
    public long minimumWeight(int n, int[][] edges, int src1, int src2, int dest) {
        List<List<Pair>> adj = new ArrayList<>();
        List<List<Pair>> revAdj = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
            revAdj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj.get(u).add(new Pair(v, w));
            revAdj.get(v).add(new Pair(u, w));
        }

        long[] dist1 = dijkstra(n, adj, src1);
        long[] dist2 = dijkstra(n, adj, src2);
        long[] distDest = dijkstra(n, revAdj, dest);

        long ans = Long.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (dist1[i] != Long.MAX_VALUE && dist2[i] != Long.MAX_VALUE && distDest[i] != Long.MAX_VALUE) {
                ans = Math.min(ans, dist1[i] + dist2[i] + distDest[i]);
            }
        }

        return ans == Long.MAX_VALUE ? -1 : ans;
    }

    private long[] dijkstra(int n, List<List<Pair>> adj, int src) {
        long[] dist = new long[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[src] = 0;

        PriorityQueue<Pair> pq = new PriorityQueue<>(Comparator.comparingLong(p -> p.weight));
        pq.offer(new Pair(src, 0));

        while (!pq.isEmpty()) {
            Pair curr = pq.poll();
            int u = curr.node;
            long weight = curr.weight;

            if (weight > dist[u]) continue;

            for (Pair neighbor : adj.get(u)) {
                int v = neighbor.node;
                long w = neighbor.weight;

                if (dist[u] + w < dist[v]) {
                    dist[v] = dist[u] + w;
                    pq.offer(new Pair(v, dist[v]));
                }
            }
        }

        return dist;
    }

    static class Pair {
        int node;
        long weight;

        public Pair(int node, long weight) {
            this.node = node;
            this.weight = weight;
        }
    }
}