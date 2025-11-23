public class Solution {

import java.util.*;

public class Solution {
    public int[][] validArrangement(int[][] pairs) {
        Map<Integer, Deque<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> inDegree = new HashMap<>();
        Map<Integer, Integer> outDegree = new HashMap<>();

        for (int[] pair : pairs) {
            int u = pair[0];
            int v = pair[1];
            graph.putIfAbsent(u, new LinkedList<>());
            graph.get(u).add(v);
            outDegree.put(u, outDegree.getOrDefault(u, 0) + 1);
            inDegree.put(v, inDegree.getOrDefault(v, 0) + 1);
        }

        int startNode = pairs[0][0];
        for (int node : outDegree.keySet()) {
            if (outDegree.get(node) > inDegree.getOrDefault(node, 0)) {
                startNode = node;
                break;
            }
        }

        List<Integer> path = new ArrayList<>();
        dfs(startNode, graph, path);

        int[][] result = new int[pairs.length][2];
        for (int i = 0; i < result.length; i++) {
            result[i][0] = path.get(i);
            result[i][1] = path.get(i + 1);
        }

        return result;
    }

    private void dfs(int node, Map<Integer, Deque<Integer>> graph, List<Integer> path) {
        while (!graph.getOrDefault(node, new LinkedList<>()).isEmpty()) {
            int next = graph.get(node).pollLast();
            dfs(next, graph, path);
        }
        path.add(node);
    }
}
}