import java.util.*;

class Solution {
    public int[][] modifiedGraphEdges(int n, int[][] edges, int source, int destination, int target) {
        List<int[]>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        List<int[]> unknownEdges = new ArrayList<>();
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];
            if (w == -1) {
                unknownEdges.add(new int[]{u, v, i});
            } else {
                adj[u].add(new int[]{v, w, i});
                adj[v].add(new int[]{u, w, i});
            }
        }

        int[][] result = new int[edges.length][3];
        for (int i = 0; i < edges.length; i++) {
            result[i] = edges[i].clone();
        }

        for (int[] edge : unknownEdges) {
            int u = edge[0];
            int v = edge[1];
            int index = edge[2];
            result[index][2] = 1;
            adj[u].add(new int[]{v, 1, index});
            adj[v].add(new int[]{u, 1, index});
        }

        int shortestPath = dijkstra(n, adj, source, destination);

        if (shortestPath > target) {
            return new int[0][];
        }

        for (int[] edge : unknownEdges) {
            int u = edge[0];
            int v = edge[1];
            int index = edge[2];
            adj[u].removeIf(e -> e[0] == v && e[2] == index);
            adj[v].removeIf(e -> e[0] == u && e[2] == index);

            int diff = target - shortestPath;
            int w = Math.min(1000, result[index][2] + diff);
            result[index][2] = w;
            adj[u].add(new int[]{v, w, index});
            adj[v].add(new int[]{u, w, index});

            shortestPath = dijkstra(n, adj, source, destination);
            if(shortestPath > target){
                result[index][2] = 1000;
                adj[u].removeIf(e -> e[0] == v && e[2] == index);
                adj[v].removeIf(e -> e[0] == u && e[2] == index);
                adj[u].add(new int[]{v, 1000, index});
                adj[v].add(new int[]{u, 1000, index});
                shortestPath = dijkstra(n, adj, source, destination);

            }
            if(shortestPath < target){
                 diff = target - shortestPath;
                w = Math.min(1000, result[index][2] + diff);
                result[index][2] = w;
                adj[u].removeIf(e -> e[0] == v && e[2] == index);
                adj[v].removeIf(e -> e[0] == u && e[2] == index);
                adj[u].add(new int[]{v, w, index});
                adj[v].add(new int[]{u, w, index});
                shortestPath = dijkstra(n, adj, source, destination);

            }

        }
        if (dijkstra(n, adj, source, destination) != target) {
            return new int[0][];
        }

        return result;
    }

    private int dijkstra(int n, List<int[]>[] adj, int source, int destination) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[source] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{0, source});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int d = curr[0];
            int u = curr[1];

            if (d > dist[u]) {
                continue;
            }

            for (int[] edge : adj[u]) {
                int v = edge[0];
                int w = edge[1];
                if (dist[u] != Integer.MAX_VALUE && dist[u] + w < dist[v]) {
                    dist[v] = dist[u] + w;
                    pq.offer(new int[]{dist[v], v});
                }
            }
        }

        return dist[destination] == Integer.MAX_VALUE ? Integer.MAX_VALUE : dist[destination];
    }
}