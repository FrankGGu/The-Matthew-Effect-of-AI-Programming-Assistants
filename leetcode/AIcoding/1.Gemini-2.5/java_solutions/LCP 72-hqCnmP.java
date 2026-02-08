import java.util.*;

class Solution {
    public long minimizeTotalCost(int n, int[][] roads, int[] cost) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] road : roads) {
            int u = road[0];
            int v = road[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        long[] result = dfs(0, -1, adj, cost);
        return Math.min(result[0], result[1]);
    }

    // Returns long[2] where:
    // result[0] is the minimum cost for the subtree rooted at 'u' if 'u' is NOT supplied.
    // result[1] is the minimum cost for the subtree rooted at 'u' if 'u' IS supplied.
    private long[] dfs(int u, int parent, List<List<Integer>> adj, int[] cost) {
        long dp0 = 0; // Cost if u is not supplied
        long dp1 = cost[u]; // Cost if u is supplied

        for (int v : adj.get(u)) {
            if (v == parent) {
                continue;
            }

            long[] childDp = dfs(v, u, adj, cost);

            // If u is not supplied, all its neighbors (including child v) must be supplied.
            dp0 += childDp[1];

            // If u is supplied, child v can either be supplied or not.
            dp1 += Math.min(childDp[0], childDp[1]);
        }

        return new long[]{dp0, dp1};
    }
}