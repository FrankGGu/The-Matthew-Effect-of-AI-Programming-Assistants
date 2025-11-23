import java.util.*;

class Solution {
    private int timer;

    public List<List<Integer>> criticalConnections(int n, List<List<Integer>> connections) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (List<Integer> connection : connections) {
            int u = connection.get(0);
            int v = connection.get(1);
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[] disc = new int[n];
        int[] low = new int[n];
        int[] parent = new int[n];
        Arrays.fill(disc, -1);
        Arrays.fill(parent, -1);
        timer = 0;
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (disc[i] == -1) {
                dfs(i, adj, disc, low, parent, result);
            }
        }

        return result;
    }

    private void dfs(int node, List<List<Integer>> adj, int[] disc, int[] low, int[] parent, List<List<Integer>> result) {
        disc[node] = low[node] = timer++;

        for (int neighbor : adj.get(node)) {
            if (disc[neighbor] == -1) {
                parent[neighbor] = node;
                dfs(neighbor, adj, disc, low, parent, result);
                low[node] = Math.min(low[node], low[neighbor]);

                if (low[neighbor] > disc[node]) {
                    result.add(Arrays.asList(node, neighbor));
                }
            } else if (neighbor != parent[node]) {
                low[node] = Math.min(low[node], disc[neighbor]);
            }
        }
    }
}