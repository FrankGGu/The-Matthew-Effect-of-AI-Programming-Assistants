import java.util.*;

class Solution {
    public int minimumTotalPrice(int n, int[][] edges, int[] price, int[][] trips) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] count = new int[n];
        for (int[] trip : trips) {
            dfs(trip[0], trip[1], adj, count, new boolean[n], new ArrayList<>());
        }

        int[] dp = new int[n];
        int[] dpHalf = new int[n];
        boolean[] visited = new boolean[n];

        function(0, -1, adj, count, price, dp, dpHalf, visited);

        return Math.min(dp[0], dpHalf[0]);
    }

    private boolean dfs(int start, int end, List<List<Integer>> adj, int[] count, boolean[] visited, List<Integer> path) {
        visited[start] = true;
        path.add(start);

        if (start == end) {
            for (int node : path) {
                count[node]++;
            }
            visited[start] = false;
            path.remove(path.size() - 1);
            return true;
        }

        for (int neighbor : adj.get(start)) {
            if (!visited[neighbor]) {
                if (dfs(neighbor, end, adj, count, visited, path)) {
                    visited[start] = false;
                    path.remove(path.size() - 1);
                    return true;
                }
            }
        }

        visited[start] = false;
        path.remove(path.size() - 1);
        return false;
    }

    private void function(int node, int parent, List<List<Integer>> adj, int[] count, int[] price, int[] dp, int[] dpHalf, boolean[] visited) {
        visited[node] = true;
        dp[node] = count[node] * price[node];
        dpHalf[node] = count[node] * price[node] / 2;

        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                function(neighbor, node, adj, count, price, dp, dpHalf, visited);
                dp[node] += Math.min(dp[neighbor], dpHalf[neighbor]);
                dpHalf[node] += dp[neighbor];
            }
        }
    }
}