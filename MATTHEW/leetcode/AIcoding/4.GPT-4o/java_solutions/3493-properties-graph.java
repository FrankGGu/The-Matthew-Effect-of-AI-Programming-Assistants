import java.util.*;

class Solution {
    public List<Integer> findPropertiesGraph(int n, int[][] edges) {
        List<Integer> result = new ArrayList<>();
        Set<Integer> visited = new HashSet<>();
        Map<Integer, List<Integer>> graph = new HashMap<>();

        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        for (int i = 1; i <= n; i++) {
            if (!visited.contains(i)) {
                Set<Integer> component = new HashSet<>();
                dfs(i, graph, visited, component);
                if (component.size() % 2 == 0) {
                    result.addAll(component);
                }
            }
        }
        Collections.sort(result);
        return result;
    }

    private void dfs(int node, Map<Integer, List<Integer>> graph, Set<Integer> visited, Set<Integer> component) {
        visited.add(node);
        component.add(node);
        for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
            if (!visited.contains(neighbor)) {
                dfs(neighbor, graph, visited, component);
            }
        }
    }
}