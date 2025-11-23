import java.util.*;

class Solution {
    List<List<Integer>> adj;
    int[] nodeValues;

    private int[] dfs(int u, int parent) {
        int[] dp = new int[2];

        dp[1] = nodeValues[u];

        for (int v : adj.get(u)) {
            if (v == parent) {
                continue;
            }
            int[] childDp = dfs(v, u);

            dp[0] += Math.max(childDp[0], childDp[1]);

            dp[1] += childDp[0];
        }

        return dp;
    }

    public int solve(int n, int[] values, int[][] edges) {
        nodeValues = values;

        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[] result = dfs(0, -1);

        return Math.max(result[0], result[1]);
    }
}