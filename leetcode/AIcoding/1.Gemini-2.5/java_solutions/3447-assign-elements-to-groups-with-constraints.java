import java.util.*;

class Solution {
    private int N_flow_nodes; // Total nodes in the flow network
    private int[][] capacity;
    private List<List<Integer>> adj;
    private int[] parent;

    private int bfs(int s, int t) {
        parent = new int[N_flow_nodes];
        Arrays.fill(parent, -1);
        Queue<Integer> q = new LinkedList<>();
        q.offer(s);
        parent[s] = s; // Mark source as visited and its parent as itself

        int[] flow = new int[N_flow_nodes];
        Arrays.fill(flow, 0);
        flow[s] = Integer.MAX_VALUE; // Max flow through source is effectively infinite

        while (!q.isEmpty()) {
            int u = q.poll();

            for (int v : adj.get(u)) {
                if (parent[v] == -1 && capacity[u][v] > 0) { // If v is not visited and there's capacity
                    parent[v] = u;
                    flow[v] = Math.min(flow[u], capacity[u][v]);
                    if (v == t) {
                        return flow[t]; // Found an augmenting path to the sink
                    }
                    q.offer(v);
                }
            }
        }
        return 0; // No augmenting path found
    }

    private int edmondsKarp(int s, int t) {
        int maxFlow = 0;
        int pathFlow;

        while ((pathFlow = bfs(s, t)) > 0) { // While an augmenting path exists
            maxFlow += pathFlow;
            int v = t;
            while (v != s) { // Backtrack to update capacities along the path
                int u = parent[v];
                capacity[u][v] -= pathFlow; // Reduce forward capacity
                capacity[v][u] += pathFlow; // Increase backward capacity (for residual graph)
                v = u;
            }
        }
        return maxFlow;
    }

    public int assignToGroups(int[] nums, int[][] constraints) {
        int n_elements = nums.length;

        // Build conflict matrix
        boolean[][] isConflict = new boolean[n_elements][n_elements];
        for (int[] constraint : constraints) {
            int u = constraint[0];
            int v = constraint[1];
            isConflict[u][v] = true;
            isConflict[v][u] = true; // Constraints are bidirectional
        }

        // Create flow network for maximum bipartite matching
        // Nodes: S (0), U_0..U_{n_elements-1} (1..n_elements), V_0..V_{n_elements-1} (n_elements+1..2*n_elements), T (2*n_elements+1)
        N_flow_nodes = 2 * n_elements + 2; // Total nodes in the flow network
        int s = 0; // Source node
        int t = 2 * n_elements + 1; // Sink node

        capacity = new int[N_flow_nodes][N_flow_nodes];
        adj = new ArrayList<>(N_flow_nodes);
        for (int i = 0; i < N_flow_nodes; i++) {
            adj.add(new ArrayList<>());
        }

        // Add edges from Source (S) to U_i (left side of bipartite graph)
        // Each element can be the first element of a group
        for (int i = 0; i < n_elements; i++) {
            addEdge(s, i + 1, 1);
        }

        // Add edges from V_j (right side of bipartite graph) to Sink (T)
        // Each element can be the second element of a group
        for (int j = 0; j < n_elements; j++) {
            addEdge(n_elements + j + 1, t, 1);
        }

        // Add edges from U_i to V_j based on problem constraints
        // U_i corresponds to original index i (node i+1)
        // V_j corresponds to original index j (node n_elements+j+1)
        for (int i = 0; i < n_elements; i++) {
            for (int j = 0; j < n_elements; j++) {
                // Conditions for forming a valid group of two (i, j):
                // 1. i and j must be distinct elements (a group needs at least two elements, and they must be distinct original indices)
                // 2. nums[i] <= nums[j] (for non-decreasing order within the group)
                // 3. (i, j) must not be a global constraint (nums[i] and nums[j] cannot be in the same group)
                if (i != j && nums[i] <= nums[j] && !isConflict[i][j]) {
                    addEdge(i + 1, n_elements + j + 1, 1);
                }
            }
        }

        // The maximum flow in this network represents the maximum number of disjoint pairs (groups of size 2)
        // that satisfy all conditions. Since maximizing the number of groups implies making them as small
        // as possible (size 2), this maximum matching is the answer.
        return edmondsKarp(s, t);
    }

    // Helper to add an edge to the graph and its reverse for residual graph
    private void addEdge(int u, int v, int cap) {
        capacity[u][v] = cap;
        adj.get(u).add(v);
        adj.get(v).add(u); // Add reverse edge for residual graph (initial capacity 0)
    }
}