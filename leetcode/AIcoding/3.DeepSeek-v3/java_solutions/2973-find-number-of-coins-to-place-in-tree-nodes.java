class Solution {
    public int[] placedCoins(int[][] edges, int[] cost) {
        int n = cost.length;
        List<Integer>[] tree = new List[n];
        for (int i = 0; i < n; i++) {
            tree[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            tree[u].add(v);
            tree[v].add(u);
        }
        int[] res = new int[n];
        dfs(0, -1, tree, cost, res);
        return res;
    }

    private List<Integer> dfs(int node, int parent, List<Integer>[] tree, int[] cost, int[] res) {
        List<Integer> values = new ArrayList<>();
        values.add(cost[node]);
        for (int child : tree[node]) {
            if (child != parent) {
                List<Integer> childValues = dfs(child, node, tree, cost, res);
                values.addAll(childValues);
            }
        }
        Collections.sort(values);
        int size = values.size();
        if (size < 3) {
            res[node] = 1;
        } else {
            long max1 = (long) values.get(0) * values.get(1) * values.get(size - 1);
            long max2 = (long) values.get(size - 3) * values.get(size - 2) * values.get(size - 1);
            res[node] = Math.max(max1, max2) > 0 ? 0 : 1;
        }
        return values;
    }
}