import java.util.*;

public class Solution {
    public int minimumWeight(int n, int[][] edges, int src1, int src2, int dest) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) graph.add(new ArrayList<>());
        for (int[] edge : edges) {
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        int[] dist1 = dijkstra(n, graph, src1);
        int[] dist2 = dijkstra(n, graph, src2);
        int[] distDest = dijkstra(n, graph, dest);

        int minWeight = Integer.MAX_VALUE;
        for (int u = 0; u < n; u++) {
            if (dist1[u] != Integer.MAX_VALUE && dist2[u] != Integer.MAX_VALUE && distDest[u] != Integer.MAX_VALUE) {
                minWeight = Math.min(minWeight, dist1[u] + dist2[u] + distDest[u]);
            }
        }

        return minWeight == Integer.MAX_VALUE ? -1 : minWeight;
    }

    private int[] dijkstra(int n, List<List<int[]>> graph, int src) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[src] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{src, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0], d = curr[1];
            if (d > dist[node]) continue;

            for (int[] edge : graph.get(node)) {
                int neighbor = edge[0], weight = edge[1];
                if (dist[node] + weight < dist[neighbor]) {
                    dist[neighbor] = dist[node] + weight;
                    pq.offer(new int[]{neighbor, dist[neighbor]});
                }
            }
        }

        return dist;
    }
}