public class Solution {

import java.util.*;

public class Solution {
    public int waysToReconstructTree(int[][] pairs) {
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        Set<Integer> nodes = new HashSet<>();

        for (int[] pair : pairs) {
            nodes.add(pair[0]);
            nodes.add(pair[1]);
            graph.putIfAbsent(pair[0], new HashSet<>());
            graph.get(pair[0]).add(pair[1]);
            graph.putIfAbsent(pair[1], new HashSet<>());
            graph.get(pair[1]).add(pair[0]);
        }

        List<Integer> nodeOrder = new ArrayList<>(nodes);
        Collections.sort(nodeOrder);

        int[] degree = new int[nodes.size() + 1];
        for (int u : nodes) {
            degree[u] = graph.get(u).size();
        }

        int n = nodeOrder.size();
        int result = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int u = nodeOrder.get(i);
                int v = nodeOrder.get(j);
                if (graph.get(u).contains(v)) {
                    if (degree[u] == 1 && degree[v] == 1) {
                        result++;
                    }
                }
            }
        }

        return result;
    }
}
}