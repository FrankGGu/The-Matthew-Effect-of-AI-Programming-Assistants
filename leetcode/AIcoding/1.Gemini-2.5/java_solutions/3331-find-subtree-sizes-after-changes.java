import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<List<Integer>> adj;
    private int[] tin; // Entry time in DFS traversal
    private int[] tout; // Exit time (max timer value in subtree) in DFS traversal
    private int timer; // Global timer for DFS
    private int[] bit; // Fenwick tree (Binary Indexed Tree)
    private boolean[] active; // State of each node: true if active, false if inactive

    // Fenwick Tree (BIT) methods
    private void update(int idx, int delta) {
        for (; idx < bit.length; idx += idx & -idx) {
            bit[idx] += delta;
        }
    }

    private int query(int idx) {
        int sum = 0;
        for (; idx > 0; idx -= idx & -idx) {
            sum += bit[idx];
        }
        return sum;
    }

    // DFS traversal to compute tin and tout values for each node
    // tin[u] is the time when DFS enters node u.
    // tout[u] is the maximum tin value encountered in the subtree rooted at u.
    // This defines a range [tin[u], tout[u]] in the flattened DFS traversal
    // such that all nodes v in the subtree of u satisfy tin[u] <= tin[v] <= tout[u].
    private void dfs(int u, int p) {
        tin[u] = ++timer;
        for (int v : adj.get(u)) {
            if (v != p) {
                dfs(v, u);
            }
        }
        tout[u] = timer;
    }

    public List<Integer> findSubtreeSizesAfterChanges(int n, int[][] edges, int[][] queries) {
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0]; // Assuming 0-indexed nodes
            int v = edge[1]; // Assuming 0-indexed nodes
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        tin = new int[n];
        tout = new int[n];
        timer = 0;
        dfs(0, -1); // Start DFS from node 0, with -1 as parent (assuming connected graph)

        // Initialize Fenwick tree and active states
        // The BIT size needs to be `timer + 1` because `timer` can go up to `n`
        // and `tin`/`tout` values are 1-indexed for BIT.
        bit = new int[timer + 1];
        active = new boolean[n];
        for (int i = 0; i < n; i++) {
            active[i] = true; // Initially all nodes are active
            update(tin[i], 1); // Add 1 to BIT for each active node at its tin position
        }

        List<Integer> results = new ArrayList<>();
        for (int[] query : queries) {
            int type = query[0];
            int u = query[1]; // Node index for the query

            if (type == 1) { // Toggle state of node u
                if (active[u]) {
                    update(tin[u], -1); // Node u becomes inactive, remove its contribution
                } else {
                    update(tin[u], 1); // Node u becomes active, add its contribution
                }
                active[u] = !active[u];
            } else { // Query subtree size of u (count of active nodes in subtree)
                // The sum of active nodes in the subtree of u is query(tout[u]) - query(tin[u] - 1).
                // This range query works because `tin[u]` marks the start of the subtree's flattened
                // representation, and `tout[u]` marks the end. All nodes `v` in the subtree of `u`
                // will have `tin[u] <= tin[v] <= tout[u]`.
                results.add(query(tout[u]) - query(tin[u] - 1));
            }
        }

        return results;
    }
}