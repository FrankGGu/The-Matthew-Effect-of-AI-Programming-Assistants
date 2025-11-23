import java.util.*;

public class Solution {
    public List<List<Integer>> getAncestors(int n, int[][] edges) {
        List<List<Integer>> result = new ArrayList<>();
        List<Set<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new HashSet<>());
            result.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[1]).add(edge[0]);
        }
        for (int i = 0; i < n; i++) {
            boolean[] visited = new boolean[n];
            findAncestors(graph, i, visited, result.get(i));
        }
        return result;
    }

    private void findAncestors(List<Set<Integer>> graph, int node, boolean[] visited, List<Integer> ancestors) {
        if (visited[node]) return;
        visited[node] = true;
        for (int ancestor : graph.get(node)) {
            ancestors.add(ancestor);
            findAncestors(graph, ancestor, visited, ancestors);
        }
    }
}