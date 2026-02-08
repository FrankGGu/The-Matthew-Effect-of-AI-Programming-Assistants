import java.util.*;

class Solution {
    public int numberOfWays(int n, int[][] pairs) {
        if (n == 1) {
            return 1; // A single node is always a valid tree, 1 way.
        }

        Map<Integer, Set<Integer>> adj = new HashMap<>();
        // Populate adj map with connections from pairs
        for (int[] pair : pairs) {
            adj.computeIfAbsent(pair[0], k -> new HashSet<>()).add(pair[1]);
            adj.computeIfAbsent(pair[1], k -> new HashSet<>()).add(pair[0]);
        }

        // Add self to each set, as u is considered connected to u
        for (int u : new ArrayList<>(adj.keySet())) {
            adj.get(u).add(u);
        }

        // Check if all n nodes are present in the pairs.
        // If some nodes are missing from pairs, they cannot form a connected tree of size n.
        if (adj.size() != n) {
            return 0;
        }

        List<Integer> nodes = new ArrayList<>(adj.keySet());
        // Sort nodes by the size of their adj set in descending order.
        // Nodes with larger sets are considered "higher" in the tree hierarchy (closer to the root).
        Collections.sort(nodes, (a, b) -> adj.get(b).size() - adj.get(a).size());

        // The first node in the sorted list is the candidate root.
        // Its adj set must contain all n nodes, as it's connected to everyone.
        int root = nodes.get(0);
        if (adj.get(root).size() != n) {
            return 0;
        }

        int ans = 1; // Initialize with 1 way

        // Iterate through nodes from the second one (potential children)
        for (int i = 1; i < n; i++) {
            int u = nodes.get(i);
            int parent = -1;
            int parentSize = -1;

            // Find the immediate parent for u among nodes already processed (which are higher in the tree hierarchy)
            for (int j = 0; j < i; j++) {
                int v = nodes.get(j);
                // v is a candidate parent if adj[u] is a subset of adj[v].
                // This means v is an ancestor of u.
                if (adj.get(v).containsAll(adj.get(u))) {
                    if (parent == -1 || adj.get(v).size() < parentSize) {
                        // Found a closer ancestor (smaller adj set size)
                        parent = v;
                        parentSize = adj.get(v).size();
                    } else if (adj.get(v).size() == parentSize) {
                        // Found another ancestor (v) with the same minimal superset size as 'parent'.
                        // This implies ambiguity: u could be a child of 'parent' or 'v'.
                        // This leads to multiple ways to reconstruct the tree.
                        ans = 2;
                    }
                }
            }

            // If no parent is found for u, then no valid tree can be formed.
            if (parent == -1) {
                return 0;
            }

            // If adj[u] is identical to adj[parent], it means u and parent are indistinguishable
            // in terms of their connectivity sets.
            // Since u and parent are distinct nodes, this indicates an ambiguity in their relationship.
            // For example, if adj[1]={1,2} and adj[2]={1,2}, then 1 could be parent of 2 or 2 could be parent of 1.
            // This leads to multiple ways (ans = 2).
            if (adj.get(u).size() == adj.get(parent).size()) {
                ans = 2;
            }
        }

        return ans;
    }
}