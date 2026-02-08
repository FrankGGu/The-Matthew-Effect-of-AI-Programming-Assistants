public class Solution {

import java.util.*;

public class Solution {
    public int maximumStarSum(int[] vals, int[][] edges) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        int maxSum = 0;
        boolean[] visited = new boolean[vals.length];

        for (int i = 0; i < vals.length; i++) {
            if (!visited[i]) {
                List<Integer> nodes = new ArrayList<>();
                dfs(i, graph, visited, nodes);
                int sum = 0;
                for (int node : nodes) {
                    sum += vals[node];
                }
                maxSum = Math.max(maxSum, sum);
            }
        }

        return maxSum;
    }

    private void dfs(int node, Map<Integer, List<Integer>> graph, boolean[] visited, List<Integer> nodes) {
        visited[node] = true;
        nodes.add(node);
        for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
            if (!visited[neighbor]) {
                dfs(neighbor, graph, visited, nodes);
            }
        }
    }
}
}