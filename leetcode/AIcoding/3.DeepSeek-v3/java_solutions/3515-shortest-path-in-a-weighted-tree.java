import java.util.*;

class Solution {
    private List<List<int[]>> graph;
    private int[] dist;

    public int[] minPathCost(int n, int[][] edges, int[][] query) {
        graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.get(u).add(new int[]{v, w});
            graph.get(v).add(new int[]{u, w});
        }

        int[] res = new int[query.length];
        for (int i = 0; i < query.length; i++) {
            int start = query[i][0], end = query[i][1];
            dist = new int[n];
            Arrays.fill(dist, Integer.MAX_VALUE);
            dist[start] = 0;
            PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
            pq.offer(new int[]{start, 0});
            while (!pq.isEmpty()) {
                int[] curr = pq.poll();
                int u = curr[0], d = curr[1];
                if (u == end) break;
                if (d > dist[u]) continue;
                for (int[] neighbor : graph.get(u)) {
                    int v = neighbor[0], w = neighbor[1];
                    if (dist[v] > dist[u] + w) {
                        dist[v] = dist[u] + w;
                        pq.offer(new int[]{v, dist[v]});
                    }
                }
            }
            res[i] = dist[end] == Integer.MAX_VALUE ? -1 : dist[end];
        }
        return res;
    }
}