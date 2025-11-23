class Solution {
    int maxCycleLength = -1;

    public int longestCycle(int[] edges) {
        int n = edges.length;
        boolean[] visited = new boolean[n]; // Tracks if a node has been visited in any DFS traversal

        // pathDist[i] stores the distance of node i from the start node of the *current* DFS path.
        // A value of -1 indicates the node is not part of the current path (or has been processed and exited).
        int[] pathDist = new int[n]; 

        // Initialize pathDist with -1
        for (int i = 0; i < n; i++) {
            pathDist[i] = -1;
        }

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                // Start a new DFS from node i if it hasn't been visited yet
                dfs(i, 0, edges, visited, pathDist);
            }
        }

        return maxCycleLength;
    }

    private void dfs(int u, int dist, int[] edges, boolean[] visited, int[] pathDist) {
        visited[u] = true;
        pathDist[u] = dist;

        int v = edges[u]; // Neighbor of u

        if (v != -1) {
            if (!visited[v]) { // Neighbor not visited yet (in any DFS)
                dfs(v, dist + 1, edges, visited, pathDist);
            } else if (pathDist[v] != -1) { // Neighbor visited and currently in the recursion stack (part of current path)
                // Cycle detected! The length is current_distance - distance_of_neighbor_in_path + 1
                maxCycleLength = Math.max(maxCycleLength, dist - pathDist[v] + 1);
            }
            // If visited[v] is true but pathDist[v] is -1, it means v was visited in a *previous*, completed DFS path.
            // In this case, there's no cycle involving v and the current path, so we do nothing.
        }

        // After processing node u and its neighbor (and any subsequent DFS calls),
        // mark u as no longer in the current path. This is crucial for correctly
        // identifying cycles in other paths/components that might visit u later.
        pathDist[u] = -1; 
    }
}