public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findLexicographicallySmallestValidSequence(int[] parent) {
        int n = parent.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            graph.get(parent[i]).add(i);
        }

        for (int i = 0; i < n; i++) {
            Collections.sort(graph.get(i));
        }

        List<Integer> result = new ArrayList<>();
        boolean[] visited = new boolean[n];
        dfs(0, graph, visited, result, n);
        return result;
    }

    private boolean dfs(int node, List<List<Integer>> graph, boolean[] visited, List<Integer> result, int n) {
        visited[node] = true;
        result.add(node);

        if (result.size() == n) {
            return true;
        }

        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                if (dfs(neighbor, graph, visited, result, n)) {
                    return true;
                }
            }
        }

        result.remove(result.size() - 1);
        visited[node] = false;
        return false;
    }
}
}