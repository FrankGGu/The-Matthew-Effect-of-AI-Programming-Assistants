import java.util.*;

class Solution {
    public int longestSpecialPath(int n, int[][] edges) {
        // Adjacency list for the graph
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        // In-degree for each node
        int[] inDegree = new int[n];

        // Build graph and calculate in-degrees
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            inDegree[v]++;
        }

        // Queue for topological sort
        Queue<Integer> q = new LinkedList<>();
        // Initialize distances. dist[i] will store the maximum number of edges
        // in a path ending at node i.
        // Initialize with -1, meaning not yet visited or reachable from a source.
        int[] dist = new int[n];
        Arrays.fill(dist, -1);

        // Add all nodes with in-degree 0 to the queue. These are potential starting points.
        // A path starting and ending at itself has 0 edges.
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                q.offer(i);
                dist[i] = 0;
            }
        }

        int maxLength = 0; // To store the overall maximum path length (number of edges)

        // Perform topological sort and update distances
        while (!q.isEmpty()) {
            int u = q.poll();
            maxLength = Math.max(maxLength, dist[u]); // Update max length found so far

            for (int v : adj.get(u)) {
                // If we can reach v from u, the path ending at v can be longer
                // by extending the path ending at u.
                // dist[u] + 1 represents the path from a source to u, plus the edge (u,v).
                if (dist[u] != -1) { // Ensure u itself was reachable from a source
                    dist[v] = Math.max(dist[v], dist[u] + 1);
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        // Handle the case where n=0
        if (n == 0) {
            return 0;
        }

        return maxLength;
    }
}