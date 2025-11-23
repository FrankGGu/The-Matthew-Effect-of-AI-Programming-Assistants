class Solution {
    public boolean[] pathExists(int n, int[][] edges, int[][] queries) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] results = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            results[i] = dfs(graph, queries[i][0], queries[i][1], new boolean[n]);
        }
        return results;
    }

    private boolean dfs(List<List<Integer>> graph, int current, int target, boolean[] visited) {
        if (current == target) return true;
        visited[current] = true;
        for (int neighbor : graph.get(current)) {
            if (!visited[neighbor] && dfs(graph, neighbor, target, visited)) {
                return true;
            }
        }
        return false;
    }
}