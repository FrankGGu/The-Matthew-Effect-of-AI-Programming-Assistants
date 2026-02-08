public class Solution {

import java.util.*;

public class Solution {
    public int longestPath(char[] chars, int[][] edges) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        int[] result = {0};
        dfs(0, -1, chars, graph, result);
        return result[0];
    }

    private int dfs(int node, int parent, char[] chars, Map<Integer, List<Integer>> graph, int[] result) {
        int max1 = 0, max2 = 0;
        for (int neighbor : graph.getOrDefault(node, Collections.emptyList())) {
            if (neighbor == parent) continue;
            int length = dfs(neighbor, node, chars, graph, result);
            if (chars[neighbor] != chars[node]) {
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