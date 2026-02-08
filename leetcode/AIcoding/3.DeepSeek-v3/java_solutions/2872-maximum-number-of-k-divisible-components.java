import java.util.*;

class Solution {
    private int res = 0;

    public int maxKDivisibleComponents(int n, int[][] edges, int[] values, int k) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.put(i, new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }
        dfs(0, -1, graph, values, k);
        return res;
    }

    private long dfs(int node, int parent, Map<Integer, List<Integer>> graph, int[] values, int k) {
        long sum = values[node];
        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                sum += dfs(neighbor, node, graph, values, k);
            }
        }
        if (sum % k == 0) {
            res++;
            return 0;
        }
        return sum;
    }
}