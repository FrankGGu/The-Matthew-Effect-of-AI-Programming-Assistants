import java.util.ArrayList;
import java.util.List;

public class Solution {
    private int time = 0;
    private List<List<Integer>> result = new ArrayList<>();

    public List<List<Integer>> criticalConnections(int n, List<List<Integer>> connections) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (List<Integer> connection : connections) {
            graph.get(connection.get(0)).add(connection.get(1));
            graph.get(connection.get(1)).add(connection.get(0));
        }

        int[] disc = new int[n];
        int[] low = new int[n];
        boolean[] visited = new boolean[n];
        dfs(0, -1, disc, low, visited, graph);

        return result;
    }

    private void dfs(int u, int parent, int[] disc, int[] low, boolean[] visited, List<List<Integer>> graph) {
        visited[u] = true;
        disc[u] = low[u] = ++time;

        for (int v : graph.get(u)) {
            if (v == parent) continue;
            if (!visited[v]) {
                dfs(v, u, disc, low, visited, graph);
                low[u] = Math.min(low[u], low[v]);
                if (low[v] > disc[u]) {
                    result.add(List.of(u, v));
                }
            } else {
                low[u] = Math.min(low[u], disc[v]);
            }
        }
    }
}