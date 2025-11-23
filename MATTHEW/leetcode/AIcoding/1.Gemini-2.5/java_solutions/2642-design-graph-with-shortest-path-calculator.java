import java.util.*;

class Graph {
    private List<int[]>[] adj; // adj[u] stores list of [v, cost]
    private int n;

    public Graph(int n, int[][] edges) {
        this.n = n;
        adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            addEdge(edge);
        }
    }

    public void addEdge(int[] edge) {
        int from = edge[0];
        int to = edge[1];
        int cost = edge[2];
        adj[from].add(new int[]{to, cost});
    }

    public int shortestPath(int node1, int node2) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);

        // PriorityQueue stores int[] {cost, node}
        // It will sort by cost (first element)
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        dist[node1] = 0;
        pq.offer(new int[]{0, node1});

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentCost = current[0];
            int u = current[1];

            // If we found a shorter path to 'u' already, skip
            if (currentCost > dist[u]) {
                continue;
            }

            // If we reached the target node, return its cost
            if (u == node2) {
                return currentCost;
            }

            for (int[] neighbor : adj[u]) {
                int v = neighbor[0];
                int edgeCost = neighbor[1];

                if (dist[u] + edgeCost < dist[v]) {
                    dist[v] = dist[u] + edgeCost;
                    pq.offer(new int[]{dist[v], v});
                }
            }
        }

        // If node2 is not reachable
        return -1;
    }
}