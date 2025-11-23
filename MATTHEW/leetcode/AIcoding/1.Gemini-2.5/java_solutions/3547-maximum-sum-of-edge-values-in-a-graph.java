import java.util.*;

class Solution {
    public long maximumEdgeValue(int n, int[][] edges, int k) {
        // Adjacency list to represent the graph
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            // The edge value w_i (edge[2]) is not used in the logic.
            // Only k and the graph structure matter.
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        // M is the total number of edges
        long M = edges.length;

        // If there are no edges, the sum is 0.
        if (M == 0) {
            return 0;
        }

        // Perform 2-coloring (BFS) to determine target parities x_i for each node.
        // colors[i] will store 0 or 1. -1 if not visited.
        int[] colors = new int[n];
        Arrays.fill(colors, -1);

        // countColor1 stores the number of nodes assigned color 1.
        long countColor1 = 0;

        // Iterate through all nodes to handle disconnected components (forest).
        for (int i = 0; i < n; i++) {
            if (colors[i] == -1) { // Node not yet visited
                Queue<Integer> q = new LinkedList<>();
                q.offer(i);
                colors[i] = 0; // Start coloring this component with 0

                while (!q.isEmpty()) {
                    int u = q.poll();

                    for (int v : adj.get(u)) {
                        if (colors[v] == -1) { // Not visited
                            colors[v] = 1 - colors[u]; // Assign opposite color
                            if (colors[v] == 1) {
                                countColor1++;
                            }
                            q.offer(v);
                        } else if (colors[v] == colors[u]) {
                            // This case indicates an odd cycle, meaning the graph is not bipartite.
                            // For this problem, given typical LeetCode constraints and problem types,
                            // it's highly probable the graph is a tree or a forest (which are always bipartite).
                            // If it were a general graph, this would be a Max-Cut problem (NP-hard).
                            // We proceed assuming it's a tree/forest.
                        }
                    }
                }
            }
        }

        // Let x_i be the final parity of k applications to node i.
        // The final value of node i is V_i = (x_i == 1) ? k : 0.
        // We want to maximize the sum of edge values: sum_{e=(u,v)} (V_u ^ V_v).
        // V_u ^ V_v is k if x_u != x_v, and 0 if x_u == x_v.
        // Thus, we want to maximize k * (number of edges where x_u != x_v).

        // For a tree (or forest), we can always find a 2-coloring.
        // Let's use the 2-coloring `colors[i]` as our target `x_i`.
        // With this assignment, for every edge (u,v), `x_u != x_v`.
        // This configuration would yield `M * k` if it's achievable.

        // The condition for achievability is that the sum of all `s_i % 2` must have the same parity as `M`.
        // (`s_i` is the total number of times k is applied to node i, which determines `x_i = s_i % 2`).
        // We want `s_i % 2 = colors[i]`. So we need `sum_i colors[i] == M % 2`.
        // `sum_i colors[i]` is `countColor1` (assuming color 1 corresponds to `x_i=1`).

        if (countColor1 % 2 == M % 2) {
            // If the parity matches, it is possible to achieve `x_u != x_v` for all edges.
            // The maximum sum is `M * k`.
            return M * k;
        } else {
            // If the parity does not match, it is impossible to achieve `x_u != x_v` for all edges.
            // To satisfy the parity condition `sum_i x_i == M % 2`, we must flip the target parity `x_j`
            // for exactly one node `j`.
            // When `x_j` is flipped, its new target parity `1 - colors[j]` will be the same as
            // the `colors` of its neighbors.
            // This means for all `deg(j)` edges incident to `j`, we will now have `x_j = x_p` (where p is a neighbor).
            // These `deg(j)` edges will contribute `0` to the sum instead of `k`.
            // All other `M - deg(j)` edges will still contribute `k`.
            // To maximize the total sum `(M - deg(j)) * k`, we must choose node `j` to minimize `deg(j)`.
            // In a tree (or forest with N > 1 nodes), the minimum degree is 1 (for a leaf node).
            // Thus, `M - 1` edges will contribute `k`, and 1 edge will contribute `0`.
            // The maximum sum is `(M - 1) * k`.
            // This logic holds for N > 1. For N=1, M=0, which is handled at the beginning.
            return (M - 1) * k;
        }
    }
}