class Solution {
    public int maximumPoints(int[][] edges, int[] coins, int k) {
        int n = coins.length;
        List<Integer>[] graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].add(v);
            graph[v].add(u);
        }
        int[][] dp = new int[n][14];
        for (int[] row : dp) {
            Arrays.fill(row, -1);
        }
        return dfs(0, -1, 0, graph, coins, k, dp);
    }

    private int dfs(int u, int parent, int t, List<Integer>[] graph, int[] coins, int k, int[][] dp) {
        if (t >= 14) {
            return 0;
        }
        if (dp[u][t] != -1) {
            return dp[u][t];
        }
        int option1 = (coins[u] >> t) - k;
        int option2 = coins[u] >> (t + 1);
        for (int v : graph[u]) {
            if (v != parent) {
                option1 += dfs(v, u, t, graph, coins, k, dp);
                option2 += dfs(v, u, t + 1, graph, coins, k, dp);
            }
        }
        dp[u][t] = Math.max(option1, option2);
        return dp[u][t];
    }
}