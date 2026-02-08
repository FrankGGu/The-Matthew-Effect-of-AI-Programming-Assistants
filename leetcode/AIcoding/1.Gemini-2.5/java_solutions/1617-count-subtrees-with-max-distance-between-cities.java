import java.util.*;

class Solution {
    List<Integer>[] adj;
    int[][] dist; // Stores all-pairs shortest paths in the original tree
    int N;

    // BFS to find shortest paths from a source node
    void bfs(int startNode, int[] d) {
        Arrays.fill(d, -1);
        Queue<Integer> q = new LinkedList<>();

        q.offer(startNode);
        d[startNode] = 0;

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj[u]) {
                if (d[v] == -1) { // If not visited
                    d[v] = d[u] + 1;
                    q.offer(v);
                }
            }
        }
    }

    public int[] countSubgraphsForEachDiameter(int n, int[][] edges) {
        N = n;
        adj = new List[N + 1]; // 1-indexed cities
        for (int i = 1; i <= N; i++) {
            adj[i] = new ArrayList<>();
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].add(v);
            adj[v].add(u);
        }

        // Precompute all-pairs shortest paths in the original tree
        dist = new int[N + 1][N + 1];
        for (int i = 1; i <= N; i++) {
            bfs(i, dist[i]);
        }

        int[] ans = new int[N - 1]; // ans[d-1] for diameter d

        // Iterate through all non-empty subsets of cities
        for (int i = 1; i < (1 << N); i++) { // i represents the bitmask
            List<Integer> currentCities = new ArrayList<>();
            for (int j = 0; j < N; j++) {
                if (((i >> j) & 1) == 1) {
                    currentCities.add(j + 1); // Cities are 1-indexed
                }
            }

            if (currentCities.size() < 2) { // Need at least 2 cities to have a positive distance
                continue;
            }

            // Check connectivity and count edges within the subset
            int startNode = currentCities.get(0);
            Set<Integer> visited = new HashSet<>();
            Queue<Integer> q = new LinkedList<>();
            int edgesInSubset = 0;

            q.offer(startNode);
            visited.add(startNode);

            while (!q.isEmpty()) {
                int u = q.poll();
                for (int v : adj[u]) {
                    // Check if v is in the currentCities subset (using bitmask)
                    if (((i >> (v - 1)) & 1) == 1) { // v is in the subset
                        if (!visited.contains(v)) {
                            visited.add(v);
                            q.offer(v);
                            edgesInSubset++; 
                        }
                    }
                }
            }

            // A connected subgraph of k nodes is a tree if it has k-1 edges.
            // If visited.size() != currentCities.size(), it's not connected.
            // If edgesInSubset != currentCities.size() - 1, it's connected but not a tree (has cycles).
            if (visited.size() != currentCities.size() || edgesInSubset != currentCities.size() - 1) {
                continue; // Not a connected subtree
            }

            // Calculate diameter (maximum distance between any two cities in the current subtree)
            int maxDistInSubtree = 0;
            for (int u : currentCities) {
                for (int v : currentCities) {
                    if (u < v) { // Only consider unique pairs
                        maxDistInSubtree = Math.max(maxDistInSubtree, dist[u][v]);
                    }
                }
            }

            if (maxDistInSubtree > 0) { 
                ans[maxDistInSubtree - 1]++;
            }
        }

        return ans;
    }
}