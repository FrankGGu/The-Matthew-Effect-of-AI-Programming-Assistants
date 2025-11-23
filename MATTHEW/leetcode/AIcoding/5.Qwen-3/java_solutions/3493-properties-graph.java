public class Solution {

import java.util.*;

public class Solution {
    public int[][] validArrangement(int[][] pairs) {
        Map<Integer, Deque<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> degree = new HashMap<>();

        for (int[] pair : pairs) {
            int u = pair[0];
            int v = pair[1];
            graph.putIfAbsent(u, new ArrayDeque<>());
            graph.get(u).add(v);
            degree.put(u, degree.getOrDefault(u, 0) + 1);
            degree.put(v, degree.getOrDefault(v, 0) - 1);
        }

        int startNode = -1;
        for (Map.Entry<Integer, Integer> entry : degree.entrySet()) {
            if (entry.getValue() == -1) {
                startNode = entry.getKey();
                break;
            }
        }

        if (startNode == -1) {
            startNode = pairs[0][0];
        }

        List<int[]> path = new ArrayList<>();
        dfs(startNode, graph, path);

        int[][] result = new int[path.size()][2];
        for (int i = 0; i < path.size(); i++) {
            result[i] = path.get(i);
        }

        return result;
    }

    private void dfs(int node, Map<Integer, Deque<Integer>> graph, List<int[]> path) {
        while (!graph.getOrDefault(node, new ArrayDeque<>()).isEmpty()) {
            int next = graph.get(node).pollLast();
            dfs(next, graph, path);
            path.add(new int[]{node, next});
        }
    }
}
}