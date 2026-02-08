import java.util.ArrayList;
import java.util.List;

class Solution {
    public int countCompleteComponents(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int nodes = 0;
                int edgesInComponent = 0;
                List<Integer> componentNodes = new ArrayList<>();
                dfs(i, adj, visited, componentNodes);
                nodes = componentNodes.size();
                for (int node : componentNodes) {
                    edgesInComponent += adj.get(node).size();
                }
                edgesInComponent /= 2;

                if (edgesInComponent == (long)nodes * (nodes - 1) / 2) {
                    count++;
                }
            }
        }

        return count;
    }

    private void dfs(int node, List<List<Integer>> adj, boolean[] visited, List<Integer> componentNodes) {
        visited[node] = true;
        componentNodes.add(node);
        for (int neighbor : adj.get(node)) {
            if (!visited[neighbor]) {
                dfs(neighbor, adj, visited, componentNodes);
            }
        }
    }
}