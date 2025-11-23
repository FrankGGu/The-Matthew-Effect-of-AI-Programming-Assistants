public class Solution {

import java.util.*;

public class Solution {
    public int possibleRootNodes(int[] parent) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        Set<Integer> allNodes = new HashSet<>();

        for (int i = 0; i < parent.length; i++) {
            allNodes.add(i);
            if (parent[i] != -1) {
                graph.putIfAbsent(parent[i], new ArrayList<>());
                graph.get(parent[i]).add(i);
                allNodes.add(parent[i]);
            }
        }

        int result = 0;
        for (int node : allNodes) {
            if (isPossibleRoot(node, graph)) {
                result++;
            }
        }

        return result;
    }

    private boolean isPossibleRoot(int root, Map<Integer, List<Integer>> graph) {
        Set<Integer> visited = new HashSet<>();
        Queue<Integer> queue = new LinkedList<>();
        queue.add(root);
        visited.add(root);

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int neighbor : graph.getOrDefault(current, new ArrayList<>())) {
                if (!visited.contains(neighbor)) {
                    visited.add(neighbor);
                    queue.add(neighbor);
                }
            }
        }

        return visited.size() == graph.keySet().size() + 1;
    }
}
}