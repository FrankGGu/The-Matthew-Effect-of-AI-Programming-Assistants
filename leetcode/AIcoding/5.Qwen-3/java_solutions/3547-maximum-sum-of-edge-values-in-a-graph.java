public class Solution {

import java.util.*;

public class Solution {
    public int maxEdgeSum(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int[] degree = new int[n];
        for (int i = 0; i < n; i++) {
            degree[i] = graph.get(i).size();
        }

        Arrays.sort(degree);
        int sum = 0;
        for (int i = n - 1; i >= n - 2; i--) {
            sum += degree[i];
        }
        return sum;
    }
}
}