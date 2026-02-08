import java.util.*;

class Solution {

    private long[] dijkstra(int n, List<List<int[]>> adj, int startNode) {
        long[] dist = new long[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[startNode] = 0;

        // PriorityQueue stores {distance, node}
        PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[0]));
        pq.offer(new long[]{0, startNode});

        while (!pq.isEmpty()) {
            long[] current = pq.poll();
            long d = current[0];
            int u = (int) current[1];

            if (d > dist[u]) {
                continue;
            }

            for (int[] edge : adj.get(u)) {
                int v = edge[0];
                int weight = edge[1];

                if (dist[u] != Long.MAX_VALUE && dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.offer(new long[]{dist[v], v});
                }
            }
        }
        return dist;
    }

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

        long[] distFromSrc1 = dijkstra(n, adj, src1);
        long[] distFromSrc2 = dijkstra(n, adj, src2);
        long[] distToDest = dijkstra(n, revAdj, dest);

        long minTotalWeight = Long.MAX_VALUE;

        for (int m = 0; m < n; m++) {
            if (distFromSrc1[m] != Long.MAX_VALUE &&
                distFromSrc2[m] != Long.MAX_VALUE &&
                distToDest[m] != Long.MAX_VALUE) {

                long currentTotalWeight = distFromSrc1[m] + distFromSrc2[m] + distToDest[m];
                minTotalWeight = Math.min(minTotalWeight, currentTotalWeight);
            }
        }

        return (minTotalWeight == Long.MAX_VALUE) ? -1 : minTotalWeight;
    }
}