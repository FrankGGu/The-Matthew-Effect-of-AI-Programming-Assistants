public class Solution {

import java.util.*;

public class Solution {
    int[] coins;
    int[] dp;
    int n;

    public int maxPoints(int[] coins, int[][] edges) {
        this.coins = coins;
        n = coins.length;
        dp = new int[n];
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }
        dfs(0, -1, graph);
        return dp[0];
    }

    private int dfs(int node, int parent, List<List<Integer>> graph) {
        int total = coins[node];
        for (int child : graph.get(node)) {
            if (child != parent) {
                total += dfs(child, node, graph);
            }
        }
        dp[node] = total;
        return total;
    }
}
}