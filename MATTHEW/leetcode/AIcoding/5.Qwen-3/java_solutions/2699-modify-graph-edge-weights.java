public class Solution {

import java.util.*;

public class Solution {
    public int[] modifiedGraphEdges(int n, int[][] edges, int k, int s, int t, int target) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.get(u).add(new int[]{v, w});
            graph.get(v).add(new int[]{u, w});
        }

        int[] dist = dijkstra(n, graph, s, t);
        if (dist[t] > target) {
            return new int[0];
        }

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            if (w != -1) continue;
            edge[2] = k;
            graph.get(u).add(new int[]{v, k});
            graph.get(v).add(new int[]{u, k});
            dist = dijkstra(n, graph, s, t);
            if (dist[t] <= target) {
                int[] result = new int[edges.length];
                for (int i = 0; i < edges.length; i++) {
                    result[i] = edges[i][2];
                }
                return result;
            }
            edge[2] = -1;
            graph.get(u).remove(graph.get(u).size() - 1);
            graph.get(v).remove(graph.get(v).size() - 1);
        }

        return new int[0];
    }

    private int[] dijkstra(int n, List<List<int[]>> graph, int start, int end) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[start] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{start, 0});

        while (!pq.isEmpty()) {
            int[] node = pq.poll();
            int u = node[0], d = node[1];
            if (u == end) break;
            if (d > dist[u]) continue;
            for (int[] neighbor : graph.get(u)) {
                int v = neighbor[0], w = neighbor[1];
                if (dist[v] > d + w) {
                    dist[v] = d + w;
                    pq.offer(new int[]{v, dist[v]});
                }
            }
        }

        return dist;
    }
}
}