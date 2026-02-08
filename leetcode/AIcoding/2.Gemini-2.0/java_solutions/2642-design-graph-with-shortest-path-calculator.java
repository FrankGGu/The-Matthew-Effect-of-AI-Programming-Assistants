import java.util.*;

class Graph {

    private int n;
    private List<List<int[]>> adj;

    public Graph(int n, int[][] edges) {
        this.n = n;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            addEdge(edge);
        }
    }

    public void addEdge(int[] edge) {
        int u = edge[0];
        int v = edge[1];
        int cost = edge[2];
        adj.get(u).add(new int[]{v, cost});
    }

    public int shortestPath(int node1, int node2) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[node1] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{node1, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0];
            int d = curr[1];

            if (d > dist[u]) {
                continue;
            }

            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                int cost = neighbor[1];
                if (dist[u] != Integer.MAX_VALUE && dist[u] + cost < dist[v]) {
                    dist[v] = dist[u] + cost;
                    pq.offer(new int[]{v, dist[v]});
                }
            }
        }

        return dist[node2] == Integer.MAX_VALUE ? -1 : dist[node2];
    }
}