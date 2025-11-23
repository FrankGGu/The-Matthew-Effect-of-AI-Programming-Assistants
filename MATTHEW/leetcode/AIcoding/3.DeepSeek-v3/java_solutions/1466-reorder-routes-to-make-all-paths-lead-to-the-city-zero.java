class Solution {
    public int minReorder(int n, int[][] connections) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : connections) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(-edge[0]);
        }
        boolean[] visited = new boolean[n];
        return dfs(adj, visited, 0);
    }

    private int dfs(List<List<Integer>> adj, boolean[] visited, int u) {
        visited[u] = true;
        int res = 0;
        for (int v : adj.get(u)) {
            if (!visited[Math.abs(v)]) {
                res += dfs(adj, visited, Math.abs(v)) + (v > 0 ? 1 : 0);
            }
        }
        return res;
    }
}