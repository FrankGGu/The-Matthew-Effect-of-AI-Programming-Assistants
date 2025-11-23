import java.util.ArrayList;
import java.util.List;

class Solution {
    public long countPairs(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        List<Integer> componentSizes = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int size = dfs(i, adj, visited);
                componentSizes.add(size);
            }
        }

        long unreachablePairs = 0;
        long remainingNodes = n;
        for (int size : componentSizes) {
            unreachablePairs += (long) size * (remainingNodes - size);
            remainingNodes -= size;
        }

        return unreachablePairs;
    }

    private int dfs(int node, List<List<Integer>> adj, boolean[] visited) {
        visited[node] = true;
        int size = 1;
        for (int neighbor : adj.get(node)) {
            if (!visited[neighbor]) {
                size += dfs(neighbor, adj, visited);
            }
        }
        return size;
    }
}