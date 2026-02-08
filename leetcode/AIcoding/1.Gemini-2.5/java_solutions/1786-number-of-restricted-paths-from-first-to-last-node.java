import java.util.*;

class Solution {
    private static final int MOD = 1_000_000_007;

    public int countRestrictedPaths(int n, int[][] edges) {
        // Step 1: Build adjacency list for the graph
        // Each entry in adj.get(u) is an array {v, weight}
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj.get(u).add(new int[]{v, w});
            adj.get(v).add(new int[]{u, w}); // Graph is undirected
        }

        // Step 2: Calculate shortest distances from node n to all other nodes using Dijkstra's algorithm
        long[] dist = new long[n + 1];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[n] = 0; // Shortest distance from n to n is 0

        // PriorityQueue stores {distance, node} pairs, ordered by distance
        // We use long[] for elements to store distance (long) and node (int, cast to long for consistency)
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[0], b[0]));
        pq.offer(new long[]{0, n}); // Start Dijkstra from node n

        while (!pq.isEmpty()) {
            long[] current = pq.poll();
            long d = current[0];
            int u = (int) current[1];

            // If we found a shorter path to u already, skip
            if (d > dist[u]) {
                continue;
            }

            // Explore neighbors of u
            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                int weight = neighbor[1];

                // If a shorter path to v is found through u
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.offer(new long[]{dist[v], v});
                }
            }
        }

        // Step 3: Create a list of all nodes and sort them based on their shortest distance to node n
        // Nodes with smaller dist[u] values will be processed first.
        List<Integer> nodes = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            nodes.add(i);
        }
        nodes.sort((a, b) -> Long.compare(dist[a], dist[b]));

        // Step 4: Dynamic Programming to count restricted paths
        // dp[u] will store the number of restricted paths from node u to node n
        int[] dp = new int[n + 1];
        dp[n] = 1; // There is one restricted path from n to n (the path consisting only of node n)

        // Iterate through nodes in increasing order of their distance to n
        for (int u : nodes) {
            // For each neighbor v of u
            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                // A path u -> v is part of a restricted path if dist[u] > dist[v]
                if (dist[u] > dist[v]) {
                    // Add the number of restricted paths from v to n to dp[u]
                    dp[u] = (dp[u] + dp[v]) % MOD;
                }
            }
        }

        // The result is the number of restricted paths from node 1 to node n
        return dp[1];
    }
}