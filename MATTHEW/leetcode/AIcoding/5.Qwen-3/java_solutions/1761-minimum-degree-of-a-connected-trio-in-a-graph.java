public class Solution {

import java.util.*;

public class Solution {
    public int minTrioDegrees(int n, int[][] edges) {
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        for (int i = 1; i <= n; i++) {
            graph.put(i, new HashSet<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int minDegree = Integer.MAX_VALUE;

        for (int i = 1; i <= n; i++) {
            for (int j : graph.get(i)) {
                if (j > i) {
                    for (int k : graph.get(j)) {
                        if (k > j && graph.get(i).contains(k)) {
                            int degree = graph.get(i).size() + graph.get(j).size() + graph.get(k).size() - 6;
                            minDegree = Math.min(minDegree, degree);
                        }
                    }
                }
            }
        }

        return minDegree == Integer.MAX_VALUE ? 0 : minDegree;
    }
}
}