public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findPorts(int[][] connections) {
        Map<Integer, Integer> inDegree = new HashMap<>();
        Map<Integer, Set<Integer>> graph = new HashMap<>();

        for (int[] conn : connections) {
            int u = conn[0];
            int v = conn[1];

            inDegree.put(u, inDegree.getOrDefault(u, 0) + 1);
            inDegree.put(v, inDegree.getOrDefault(v, 0));

            graph.putIfAbsent(u, new HashSet<>());
            graph.get(u).add(v);
        }

        List<Integer> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : inDegree.entrySet()) {
            if (entry.getValue() == 0) {
                result.add(entry.getKey());
            }
        }

        return result;
    }
}
}