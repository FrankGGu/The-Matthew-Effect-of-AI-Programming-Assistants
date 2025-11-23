import java.util.*;

public class Solution {
    public int checkWays(int[][] pairs) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> degree = new HashMap<>();

        for (int[] pair : pairs) {
            graph.putIfAbsent(pair[0], new ArrayList<>());
            graph.putIfAbsent(pair[1], new ArrayList<>());
            graph.get(pair[0]).add(pair[1]);
            graph.get(pair[1]).add(pair[0]);
            degree.put(pair[0], degree.getOrDefault(pair[0], 0) + 1);
            degree.put(pair[1], degree.getOrDefault(pair[1], 0) + 1);
        }

        int root = -1;
        for (Map.Entry<Integer, Integer> entry : degree.entrySet()) {
            if (entry.getValue() == degree.size() - 1) {
                if (root != -1) return 0;
                root = entry.getKey();
            }
        }

        if (root == -1) return 0;

        return dfs(root, graph, new HashSet<>(), -1) == -1 ? 0 : 1;
    }

    private int dfs(int node, Map<Integer, List<Integer>> graph, Set<Integer> visited, int parent) {
        visited.add(node);
        List<Integer> children = graph.get(node);
        int ways = 1;

        for (int child : children) {
            if (child == parent) continue;
            if (visited.contains(child)) return -1;
            int childWays = dfs(child, graph, visited, node);
            if (childWays == -1) return -1;
            ways *= childWays;
        }

        return ways;
    }
}