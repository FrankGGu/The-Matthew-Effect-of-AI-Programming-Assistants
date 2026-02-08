import java.util.*;

class Solution {
    public int[] countSubtrees(int n, int[][] edges, String labels) {
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

        dfs(0, adj, labels, result, visited);
        return result;
    }

    private int[] dfs(int node, List<List<Integer>> adj, String labels, int[] result, boolean[] visited) {
        visited[node] = true;
        int[] count = new int[26];
        count[labels.charAt(node) - 'a'] = 1;

        for (int neighbor : adj.get(node)) {
            if (!visited[neighbor]) {
                int[] neighborCount = dfs(neighbor, adj, labels, result, visited);
                for (int i = 0; i < 26; i++) {
                    count[i] += neighborCount[i];
                }
            }
        }

        result[node] = count[labels.charAt(node) - 'a'];
        return count;
    }
}