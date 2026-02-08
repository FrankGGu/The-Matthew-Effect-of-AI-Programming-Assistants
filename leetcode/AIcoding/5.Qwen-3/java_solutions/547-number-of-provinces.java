public class Solution {
    public int findCircleNum(int[][] isConnected) {
        int n = isConnected.length;
        boolean[] visited = new boolean[n];
        int provinces = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                dfs(i, visited, isConnected);
                provinces++;
            }
        }

        return provinces;
    }

    private void dfs(int node, boolean[] visited, int[][] graph) {
        visited[node] = true;
        for (int neighbor = 0; neighbor < graph.length; neighbor++) {
            if (graph[node][neighbor] == 1 && !visited[neighbor]) {
                dfs(neighbor, visited, graph);
            }
        }
    }
}