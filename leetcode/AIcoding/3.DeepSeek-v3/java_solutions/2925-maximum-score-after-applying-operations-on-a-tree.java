class Solution {
    public long maximumScoreAfterOperations(int[][] edges, int[] values) {
        int n = values.length;
        List<List<Integer>> tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            tree.get(u).add(v);
            tree.get(v).add(u);
        }
        long total = 0;
        for (int val : values) {
            total += val;
        }
        long minSum = dfs(tree, values, 0, -1);
        return total - minSum;
    }

    private long dfs(List<List<Integer>> tree, int[] values, int node, int parent) {
        if (tree.get(node).size() == 1 && node != 0) {
            return values[node];
        }
        long sumChildren = 0;
        for (int child : tree.get(node)) {
            if (child != parent) {
                sumChildren += dfs(tree, values, child, node);
            }
        }
        return Math.min(values[node], sumChildren);
    }
}