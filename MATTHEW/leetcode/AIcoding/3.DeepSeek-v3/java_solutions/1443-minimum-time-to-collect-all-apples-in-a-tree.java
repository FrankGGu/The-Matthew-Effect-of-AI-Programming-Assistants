class Solution {
    public int minTime(int n, int[][] edges, List<Boolean> hasApple) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }
        boolean[] visited = new boolean[n];
        return dfs(0, adj, hasApple, visited);
    }

    private int dfs(int node, List<List<Integer>> adj, List<Boolean> hasApple, boolean[] visited) {
        visited[node] = true;
        int totalTime = 0;
        for (int neighbor : adj.get(node)) {
            if (!visited[neighbor]) {
                int childTime = dfs(neighbor, adj, hasApple, visited);
                if (childTime > 0 || hasApple.get(neighbor)) {
                    totalTime += childTime + 2;
                }
            }
        }
        return totalTime;
    }
}