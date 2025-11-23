import java.util.ArrayList;
import java.util.List;

class Solution {
    public int countCompleteComponents(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        boolean[] visited = new boolean[n];
        int completeComponents = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int[] componentStats = new int[2]; 
                dfs(i, adj, visited, componentStats);

                long numVertices = componentStats[0];
                long numEdges = componentStats[1] / 2; 

                if (numEdges == numVertices * (numVertices - 1) / 2) {
                    completeComponents++;
                }
            }
        }

        return completeComponents;
    }

    private void dfs(int u, List<List<Integer>> adj, boolean[] visited, int[] componentStats) {
        visited[u] = true;
        componentStats[0]++; 
        componentStats[1] += adj.get(u).size(); 

        for (int v : adj.get(u)) {
            if (!visited[v]) {
                dfs(v, adj, visited, componentStats);
            }
        }
    }
}