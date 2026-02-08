class Solution {
    public int minTimeToCollectAllApples(int n, int[][] edges, List<Boolean> hasApple) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }
        return dfs(0, -1, graph, hasApple);
    }

    private int dfs(int node, int parent, List<List<Integer>> graph, List<Boolean> hasApple) {
        int time = 0;
        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                time += dfs(neighbor, node, graph, hasApple);
            }
        }
        if ((node != 0 && (time > 0 || hasApple.get(node)))) {
            time += 2;
        }
        return time;
    }
}