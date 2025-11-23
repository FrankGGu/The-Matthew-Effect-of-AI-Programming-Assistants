import java.util.*;

class Solution {
    public int maxStarSum(int[] vals, int[][] edges, int k) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], x -> new ArrayList<>()).add(vals[edge[1]]);
            graph.computeIfAbsent(edge[1], x -> new ArrayList<>()).add(vals[edge[0]]);
        }

        int maxSum = 0;
        for (int i = 0; i < vals.length; i++) {
            int sum = vals[i];
            List<Integer> neighbors = graph.getOrDefault(i, new ArrayList<>());
            Collections.sort(neighbors, Collections.reverseOrder());
            for (int j = 0; j < Math.min(k, neighbors.size()); j++) {
                if (neighbors.get(j) > 0) {
                    sum += neighbors.get(j);
                }
            }
            maxSum = Math.max(maxSum, sum);
        }

        return maxSum;
    }
}