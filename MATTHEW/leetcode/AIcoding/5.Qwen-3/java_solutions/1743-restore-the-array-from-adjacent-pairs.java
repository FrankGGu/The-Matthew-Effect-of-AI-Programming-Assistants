public class Solution {

import java.util.*;

public class Solution {
    public int[] restoreArray(int[][] adjacentPairs) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] pair : adjacentPairs) {
            graph.putIfAbsent(pair[0], new ArrayList<>());
            graph.putIfAbsent(pair[1], new ArrayList<>());
            graph.get(pair[0]).add(pair[1]);
            graph.get(pair[1]).add(pair[0]);
        }

        Integer start = null;
        for (Map.Entry<Integer, List<Integer>> entry : graph.entrySet()) {
            if (entry.getValue().size() == 1) {
                start = entry.getKey();
                break;
            }
        }

        int n = adjacentPairs.length + 1;
        int[] result = new int[n];
        result[0] = start;

        Set<Integer> visited = new HashSet<>();
        visited.add(start);

        for (int i = 1; i < n; i++) {
            for (int neighbor : graph.get(result[i - 1])) {
                if (!visited.contains(neighbor)) {
                    result[i] = neighbor;
                    visited.add(neighbor);
                    break;
                }
            }
        }

        return result;
    }
}
}