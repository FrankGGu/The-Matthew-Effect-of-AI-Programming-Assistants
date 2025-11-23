import java.util.ArrayList;
import java.util.List;

class Solution {
    public int maxKDivisibleComponents(int n, int[][] edges, int[] values, int k) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int count = 0;
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                if (dfs(i, adj, values, k, visited) % k == 0) {
                    count++;
                }
            }
        }

        return count;
    }

    private long dfs(int node, List<List<Integer>> adj, int[] values, int k, boolean[] visited) {
        visited[node] = true;
        long sum = values[node];

        for (int neighbor : adj.get(node)) {
            if (!visited[neighbor]) {
                sum += dfs(neighbor, adj, values, k, visited);
            }
        }

        return sum;
    }
}