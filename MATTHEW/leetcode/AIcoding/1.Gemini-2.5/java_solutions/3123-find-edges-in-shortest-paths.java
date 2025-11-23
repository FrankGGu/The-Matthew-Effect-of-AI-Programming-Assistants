import java.util.*;

class Solution {

    private static final long INF = Long.MAX_VALUE;

    private long[] dijkstra(int start, int n, List<int[]>[] adj) {
        long[] dist = new long[n];
        Arrays.fill(dist, INF);
        dist[start] = 0;

        // PriorityQueue stores {distance, node}
        PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[0]));
        pq.offer(new long[]{0, start});

        while (!pq.isEmpty()) {
            long[] current = pq.poll();
            long d = current[0];
            int u = (int) current[1];

            // If we found a shorter path to u already, skip this one
            if (d > dist[u]) {
                continue;
            }

            for (int[] edge : adj[u]) {
                int v = edge[0];
                int weight = edge[1];

                // Check if u is reachable (dist[u] is not INF)
                // and if a shorter path to v is found through u
                if (dist[u] != INF && dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.offer(new long[]{dist[v], v});
                }
            }
        }
        return dist;
    }

    public boolean[] findAnswer(int n, int[][] edges) {
        List<int[]>[] adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        // Build adjacency list for the undirected graph
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];
            adj[u].add(new int[]{v, w});
            adj[v].add(new int[]{u, w});
        }

        // Run Dijkstra from source (0) to all nodes
        long[] dist0 = dijkstra(0, n, adj);

        // Run Dijkstra from target (n-1) to all nodes
        // distN[i] will store the shortest distance from node i to n-1
        long[] distN = dijkstra(n - 1, n, adj);

        boolean[] result = new boolean[edges.length];

        // If there's no path from 0 to n-1, no edge can be part of a shortest path
        if (dist0[n - 1] == INF) {
            return result; // All elements are false by default
        }

        // Check each original edge
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];

            // An edge (u, v) with weight w is part of a shortest path from 0 to n-1
            // if dist0[u] + w + distN[v] == dist0[n-1]
            // AND u is reachable from 0 AND v can reach n-1
            boolean path_u_v = (dist0[u] != INF && distN[v] != INF && dist0[u] + w + distN[v] == dist0[n - 1]);

            // Since the graph is undirected, the path could also be 0 -> ... -> v -> u -> ... -> n-1
            boolean path_v_u = (dist0[v] != INF && distN[u] != INF && dist0[v] + w + distN[u] == dist0[n - 1]);

            result[i] = path_u_v || path_v_u;
        }

        return result;
    }
}