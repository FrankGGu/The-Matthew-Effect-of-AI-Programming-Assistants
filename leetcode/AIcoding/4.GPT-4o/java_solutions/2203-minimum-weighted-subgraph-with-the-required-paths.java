import java.util.*;

public class Solution {
    public int minimumWeight(int n, int[][] edges, int src1, int src2, int dest) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) graph.add(new ArrayList<>());
        for (int[] edge : edges) {
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
        }

        int[] dist1 = dijkstra(n, graph, src1);
        int[] dist2 = dijkstra(n, graph, src2);
        int[] distDest = dijkstra(n, graph, dest);

        int minWeight = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (dist1[i] != Integer.MAX_VALUE && dist2[i] != Integer.MAX_VALUE && distDest[i] != Integer.MAX_VALUE) {
                minWeight = Math.min(minWeight, dist1[i] + dist2[i] + distDest[i]);
            }
        }

        return minWeight == Integer.MAX_VALUE ? -1 : minWeight;
    }

    private int[] dijkstra(int n, List<List<int[]>> graph, int start) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[start] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{start, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0];
            int weight = curr[1];

            if (weight > dist[node]) continue;
            for (int[] neighbor : graph.get(node)) {
                int nextNode = neighbor[0];
                int edgeWeight = neighbor[1];
                if (dist[node] + edgeWeight < dist[nextNode]) {
                    dist[nextNode] = dist[node] + edgeWeight;
                    pq.offer(new int[]{nextNode, dist[nextNode]});
                }
            }
        }
        return dist;
    }
}