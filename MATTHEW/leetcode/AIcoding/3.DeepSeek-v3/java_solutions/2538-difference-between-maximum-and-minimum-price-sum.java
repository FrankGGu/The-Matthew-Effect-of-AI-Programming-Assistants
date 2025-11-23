class Solution {
    private long maxDiff = 0;

    public long maxOutput(int n, int[][] edges, int[] price) {
        List<List<Integer>> tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            tree.get(u).add(v);
            tree.get(v).add(u);
        }
        dfs(0, -1, tree, price);
        return maxDiff;
    }

    private long[] dfs(int node, int parent, List<List<Integer>> tree, int[] price) {
        long maxPath1 = price[node];
        long maxPath2 = 0;
        for (int neighbor : tree.get(node)) {
            if (neighbor == parent) continue;
            long[] childPaths = dfs(neighbor, node, tree, price);
            maxDiff = Math.max(maxDiff, Math.max(maxPath1 + childPaths[1], maxPath2 + childPaths[0]));
            maxPath1 = Math.max(maxPath1, childPaths[0] + price[node]);
            maxPath2 = Math.max(maxPath2, childPaths[1] + price[node]);
        }
        return new long[]{maxPath1, maxPath2};
    }
}