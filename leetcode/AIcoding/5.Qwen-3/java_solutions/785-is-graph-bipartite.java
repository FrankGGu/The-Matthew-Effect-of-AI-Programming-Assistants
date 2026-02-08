public class Solution {
    public boolean isBipartite(int[][] graph) {
        int n = graph.length;
        int[] color = new int[n];
        for (int i = 0; i < n; i++) {
            if (color[i] == 0 && !dfs(i, color, graph, 1)) {
                return false;
            }
        }
        return true;
    }

    private boolean dfs(int node, int[] color, int[][] graph, int c) {
        if (color[node] != 0) {
            return color[node] == c;
        }
        color[node] = c;
        for (int neighbor : graph[node]) {
            if (!dfs(neighbor, color, graph, -c)) {
                return false;
            }
        }
        return true;
    }
}