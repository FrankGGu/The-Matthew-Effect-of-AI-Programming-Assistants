public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> getAncestors(int n, int[][] edges) {
        List<List<Integer>> result = new ArrayList<>();
        List<List<Integer>> graph = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
        }

        for (int i = 0; i < n; i++) {
            Set<Integer> ancestors = new HashSet<>();
            Queue<Integer> queue = new LinkedList<>();
            queue.add(i);

            while (!queue.isEmpty()) {
                int node = queue.poll();
                for (int neighbor : graph.get(node)) {
                    if (!ancestors.contains(neighbor)) {
                        ancestors.add(neighbor);
                        queue.add(neighbor);
                    }
                }
            }

            List<Integer> sortedAncestors = new ArrayList<>(ancestors);
            Collections.sort(sortedAncestors);
            result.add(sortedAncestors);
        }

        return result;
    }
}
}