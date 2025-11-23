import java.util.*;

class Solution {
    public int minTrioDegree(int n, int[][] edges) {
        List<Set<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new HashSet<>());
        }

        int[] degree = new int[n + 1];
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        int minDegree = Integer.MAX_VALUE;
        for (int i = 1; i <= n; i++) {
            for (int j : graph.get(i)) {
                if (j > i) {
                    for (int k : graph.get(j)) {
                        if (k > j && graph.get(i).contains(k)) {
                            int trioDegree = degree[i] + degree[j] + degree[k] - 6;
                            minDegree = Math.min(minDegree, trioDegree);
                        }
                    }
                }
            }
        }

        return minDegree == Integer.MAX_VALUE ? -1 : minDegree;
    }
}