import java.util.*;

class Solution {
    public long maxWeightedKEdgePath(int n, int[][] edges, int k) {
        // dp[i][j] stores the maximum weight of a path of length j ending at node i.
        // Initialize with a very small number to represent unreachable states.
        // Using Long.MIN_VALUE - some_offset to ensure that adding a positive weight
        // to an unreachable state doesn't accidentally become a valid path if
        // Long.MIN_VALUE itself is used and a very large negative weight is added.
        // However, for max path, Long.MIN_VALUE is generally safe as any valid path
        // will have a larger sum.
        long[][] dp = new long[n][k + 1];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Long.MIN_VALUE);
        }

        // Base case: A path of length 0 starting and ending at any node has weight 0.
        // This assumes we can start a path from any node.
        for (int i = 0; i < n; i++) {
            dp[i][0] = 0;
        }

        // Adjacency list to represent the graph.
        // Each entry is {neighbor_node, weight}.
        List<int[]>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        // Build the graph. Assuming directed edges.
        // If the graph is undirected, edges should be added in both directions:
        // adj[u].add(new int[]{v, weight});
        // adj[v].add(new int[]{u, weight});
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int weight = edge[2];
            adj[u].add(new int[]{v, weight});
        }

        // Fill the DP table
        for (int len = 1; len <= k; len++) {
            for (int u = 0; u < n; u++) { // Iterate through all possible source nodes for the previous step
                if (dp[u][len - 1] == Long.MIN_VALUE) {
                    continue; // Node u is not reachable with len-1 edges
                }
                for (int[] edge : adj[u]) {
                    int v = edge[0];
                    int weight = edge[1];
                    // Update dp[v][len] using dp[u][len-1]
                    dp[v][len] = Math.max(dp[v][len], dp[u][len - 1] + weight);
                }
            }
        }

        // Find the maximum value among all nodes for k edges
        long maxWeight = Long.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            maxWeight = Math.max(maxWeight, dp[i][k]);
        }

        // If no path of length k exists, return -1.
        // This happens if maxWeight is still Long.MIN_VALUE.
        if (maxWeight == Long.MIN_VALUE) {
            return -1;
        }

        return maxWeight;
    }
}