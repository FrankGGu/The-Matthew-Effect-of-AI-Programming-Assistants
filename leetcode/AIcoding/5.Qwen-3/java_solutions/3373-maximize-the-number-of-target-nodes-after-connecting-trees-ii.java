public class Solution {

import java.util.*;

public class Solution {
    public int connectTrees(int[][] edges, int[] values, int target) {
        int n = values.length;
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        int[] result = {0};
        boolean[] visited = new boolean[n];

        dfs(0, -1, graph, values, target, visited, result);

        return result[0];
    }

    private int dfs(int node, int parent, Map<Integer, List<Integer>> graph, int[] values, int target, boolean[] visited, int[] result) {
        visited[node] = true;
        int count = 0;
        if (values[node] == target) {
            count++;
        }

        for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
            if (neighbor != parent && !visited[neighbor]) {
                count += dfs(neighbor, node, graph, values, target, visited, result);
            }
        }

        if (count > 0) {
            result[0]++;
        }

        return count;
    }
}
}