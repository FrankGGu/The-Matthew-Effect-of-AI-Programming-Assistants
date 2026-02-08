public class Solution {

import java.util.*;

public class Solution {
    public int longestPath(int[] parent, String s) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 1; i < parent.length; i++) {
            graph.computeIfAbsent(parent[i], k -> new ArrayList<>()).add(i);
        }

        int[] result = {0};

        dfs(0, graph, s, result);

        return result[0];
    }

    private int dfs(int node, Map<Integer, List<Integer>> graph, String s, int[] result) {
        int max1 = 0, max2 = 0;
        for (int neighbor : graph.getOrDefault(node, Collections.emptyList())) {
            int length = dfs(neighbor, graph, s, result);
            if (s.charAt(neighbor) != s.charAt(node)) {
                if (length > max1) {
                    max2 = max1;
                    max1 = length;
                } else if (length > max2) {
                    max2 = length;
                }
            }
        }
        result[0] = Math.max(result[0], max1 + max2 + 1);
        return max1 + 1;
    }
}
}