class Solution {
    public int maximumPoints(int[] coins, int[][] edges, int k) {
        int n = coins.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        Integer[][][] dp = new Integer[n][n + 1][2];

        return dfs(0, -1, 0, coins, adj, k, dp);
    }

    private int dfs(int node, int parent, int level, int[] coins, List<List<Integer>> adj, int k, Integer[][][] dp) {
        if (dp[node][level][0] != null) {
            return dp[node][level][0];
        }

        int points1 = coins[node] / (1 << level) - k;
        int points2 = coins[node] / (1 << (level + 1));

        int ans1 = points1;
        int ans2 = points2;

        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                ans1 += dfs(neighbor, node, level, coins, adj, k, dp);
                ans2 += dfs(neighbor, node, level + 1, coins, adj, k, dp);
            }
        }

        return dp[node][level][0] = Math.max(ans1 + k, ans2);
    }
}