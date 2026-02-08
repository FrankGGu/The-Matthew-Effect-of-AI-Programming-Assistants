import java.util.*;

class Solution {
    private static final long INF = Long.MAX_VALUE;

    public long minimumWeight(int n, int[][] edges, int src1, int src2, int dest) {
        List<List<int[]>> adj = new ArrayList<>();
        List<List<int[]>> revAdj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
            revAdj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj.get(u).add(new int[]{v, w});
            revAdj.get(v).add(new int[]{u, w});
        }

        long[] dist1 = new long[n];
        long[] dist2 = new long[n];
        long[] dist3 = new long[n];

        Arrays.fill(dist1, INF);
        Arrays.fill(dist2, INF);
        Arrays.fill(dist3, INF);

        dijkstra(n, adj, src1, dist1);
        dijkstra(n, adj, src2, dist2);
        dijkstra(n, revAdj, dest, dist3);

        long minTotalWeight = INF;

        for (int i = 0; i < n; i++) {
            if (dist1[i] != INF && dist2[i] != INF && dist3[i] != INF) {
                minTotalWeight = Math.min(minTotalWeight, dist1[i] + dist2[i] + dist3[i]);
            }
        }

        return minTotalWeight == INF ? -1 : minTotalWeight;
    }

    private void dijkstra(int n, List<List<int[]>> graph, int startNode, long[] distances) {
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[0], b[0]));

        distances[startNode] = 0;
        pq.offer(new long[]{0, startNode});

        while (!pq.isEmpty()) {
            long[] current = pq.poll();
            long d = current[0];
            int u = (int) current[1];

            if (d > distances[u]) {
                continue;
            }

            for (int[] edge : graph.get(u)) {
                int v = edge[0];
                int weight = edge[1];

                if (distances[u] != INF && distances[u] + weight < distances[v]) {
                    distances[v] = distances[u] + weight;
                    pq.offer(new long[]{distances[v], v});
                }
            }
        }
    }
}