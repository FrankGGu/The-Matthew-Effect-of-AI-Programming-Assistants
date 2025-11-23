import java.util.ArrayList;
import java.util.List;

class Solution {
    int changes = 0;
    List<List<int[]>> adj;
    boolean[] visited;

    public int minReorder(int n, int[][] connections) {
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] conn : connections) {
            int u = conn[0];
            int v = conn[1];
            // For an original edge u -> v:
            // Add (v, 1) to u's list: 1 indicates an outgoing edge from u to v.
            // Add (u, 0) to v's list: 0 indicates an incoming edge to v from u (i.e., original was u -> v).
            adj.get(u).add(new int[]{v, 1});
            adj.get(v).add(new int[]{u, 0});
        }

        visited = new boolean[n];
        dfs(0);
        return changes;
    }

    private void dfs(int u) {
        visited[u] = true;

        for (int[] neighborInfo : adj.get(u)) {
            int v = neighborInfo[0];
            int directionFlag = neighborInfo[1]; // 1 if original edge was u -> v, 0 if original edge was v -> u

            if (!visited[v]) {
                // If directionFlag is 1, it means the original edge was u -> v.
                // Since we are traversing from city 0, and we reached u,
                // an edge u -> v points away from city 0. To make v lead to 0,
                // this edge must be reversed to v -> u. So, we increment changes.
                if (directionFlag == 1) {
                    changes++;
                }
                // If directionFlag is 0, it means the original edge was v -> u.
                // This edge already points towards u (and eventually towards 0).
                // No change is needed.
                dfs(v);
            }
        }
    }
}