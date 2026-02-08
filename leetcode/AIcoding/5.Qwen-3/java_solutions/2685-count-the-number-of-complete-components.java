public class Solution {

import java.util.*;

public class Solution {
    public int countCompleteComponents(int n, int[][] edges) {
        List<Set<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new HashSet<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[n];
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                Set<Integer> component = new HashSet<>();
                dfs(i, graph, visited, component);
                if (isCompleteComponent(component, graph)) {
                    count++;
                }
            }
        }

        return count;
    }

    private void dfs(int node, List<Set<Integer>> graph, boolean[] visited, Set<Integer> component) {
        visited[node] = true;
        component.add(node);
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                dfs(neighbor, graph, visited, component);
            }
        }
    }

    private boolean isCompleteComponent(Set<Integer> component, List<Set<Integer>> graph) {
        for (int node : component) {
            if (graph.get(node).size() != component.size() - 1) {
                return false;
            }
        }
        return true;
    }
}
}