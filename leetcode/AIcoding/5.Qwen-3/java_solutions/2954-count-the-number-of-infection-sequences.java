public class Solution {

import java.util.*;

public class Solution {
    public int numberOfInfectionSequences(int n, int[][] edges) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        int[] degree = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            degree[i] = graph.getOrDefault(i, new ArrayList<>()).size();
        }

        int result = 0;
        boolean[] visited = new boolean[n + 1];
        List<Integer> path = new ArrayList<>();

        dfs(1, visited, path, degree, graph, n, result);

        return result;
    }

    private void dfs(int node, boolean[] visited, List<Integer> path, int[] degree, Map<Integer, List<Integer>> graph, int n, int result) {
        if (path.size() == n) {
            synchronized (this) {
                result++;
            }
            return;
        }

        visited[node] = true;
        path.add(node);

        for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
            if (!visited[neighbor]) {
                dfs(neighbor, visited, path, degree, graph, n, result);
            }
        }

        visited[node] = false;
        path.remove(path.size() - 1);
    }
}
}