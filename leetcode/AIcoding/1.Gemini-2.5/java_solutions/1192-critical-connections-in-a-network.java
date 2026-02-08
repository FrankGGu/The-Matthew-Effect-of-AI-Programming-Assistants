import java.util.*;

class Solution {
    private List<List<Integer>> adj;
    private int[] disc; // Discovery time
    private int[] low;  // Low-link value
    private int time;
    private List<List<Integer>> result;

    public List<List<Integer>> criticalConnections(int n, List<List<Integer>> connections) {
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (List<Integer> connection : connections) {
            int u = connection.get(0);
            int v = connection.get(1);
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        disc = new int[n];
        low = new int[n];
        Arrays.fill(disc, -1); // Initialize discovery times to -1 (unvisited)

        time = 0;
        result = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (disc[i] == -1) {
                dfs(i, -1); // -1 indicates no parent for the root of a DFS tree
            }
        }

        return result;
    }

    private void dfs(int u, int p) {
        disc[u] = low[u] = time++;

        for (int v : adj.get(u)) {
            if (v == p) { // Don't go back to the immediate parent
                continue;
            }
            if (disc[v] != -1) { // v is visited, it's a back-edge or cross-edge
                low[u] = Math.min(low[u], disc[v]);
            } else { // v is not visited
                dfs(v, u);
                low[u] = Math.min(low[u], low[v]); // Update low-link value of u based on v's subtree

                // If the lowest reachable time from v (and its subtree) is greater than u's discovery time,
                // then the edge (u, v) is a bridge.
                if (low[v] > disc[u]) {
                    result.add(Arrays.asList(u, v));
                }
            }
        }
    }
}