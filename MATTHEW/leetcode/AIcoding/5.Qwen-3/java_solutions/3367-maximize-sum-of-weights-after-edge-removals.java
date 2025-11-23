public class Solution {

import java.util.*;

public class Solution {
    public int maximumScore(List<Integer> parent, List<Integer> weights) {
        int n = parent.size();
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            graph.get(parent.get(i)).add(i);
        }

        int[] total = new int[1];
        dfs(0, graph, weights, total);
        return total[0];
    }

    private int dfs(int node, List<List<Integer>> graph, List<Integer> weights, int[] total) {
        int sum = weights.get(node);
        for (int child : graph.get(node)) {
            sum += dfs(child, graph, weights, total);
        }
        if (sum > 0) {
            total[0] += sum;
        }
        return sum;
    }
}
}