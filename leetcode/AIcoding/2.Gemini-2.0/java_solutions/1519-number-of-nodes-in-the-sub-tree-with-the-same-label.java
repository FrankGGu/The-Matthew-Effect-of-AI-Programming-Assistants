import java.util.*;

class Solution {
    public int[] countSubTrees(int n, int[][] edges, String labels) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] result = new int[n];
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            Arrays.fill(visited, false);
            dfs(i, adj, labels, result, visited);
        }

        return result;
    }

    private int[] dfs(int node, List<List<Integer>> adj, String labels, int[] result, boolean[] visited) {
        visited[node] = true;
        int[] counts = new int[26];
        counts[labels.charAt(node) - 'a'] = 1;

        for (int neighbor : adj.get(node)) {
            if (!visited[neighbor]) {
                int[] neighborCounts = dfs(neighbor, adj, labels, result, visited);
                for (int i = 0; i < 26; i++) {
                    counts[i] += neighborCounts[i];
                }
            }
        }
        result[node] = counts[labels.charAt(node) - 'a'];
        return counts;
    }
}