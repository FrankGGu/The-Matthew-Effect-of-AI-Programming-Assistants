class Solution {
    public long maximumScoreAfterOperations(int[] values, int[][] edges) {
        int n = values.length;
        if (n == 1) return values[0];

        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        long totalSum = 0;
        for (int val : values) {
            totalSum += val;
        }

        long[] dp = dfs(0, -1, values, adj);
        return Math.max(dp[0], dp[1]);
    }

    private long[] dfs(int node, int parent, int[] values, List<List<Integer>> adj) {
        long leave = values[node];
        long remove = 0;

        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                long[] childDp = dfs(neighbor, node, values, adj);
                leave += Math.min(childDp[0], childDp[1]);
                remove += childDp[0];
            }
        }

        return new long[]{remove, leave};
    }
}