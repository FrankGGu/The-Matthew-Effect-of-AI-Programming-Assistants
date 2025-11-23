class Solution {
    private static final int MOD = 1_000_000_007;
    private List<List<Integer>> tree;
    private int[] size;
    private int[] weight;
    private int k;

    public int numberOfWays(int n, int[][] edges, int k) {
        this.k = k;
        tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            tree.get(u).add(v);
            tree.get(v).add(u);
        }
        size = new int[n];
        weight = new int[n];
        dfs(0, -1);
        return weight[0];
    }

    private void dfs(int u, int parent) {
        size[u] = 1;
        long ways = 1;
        for (int v : tree.get(u)) {
            if (v == parent) continue;
            dfs(v, u);
            size[u] += size[v];
            ways = ways * weight[v] % MOD;
            ways = ways * comb(size[u] - 1, size[v]) % MOD;
        }
        weight[u] = (int) (ways % MOD);
    }

    private int comb(int n, int k) {
        long res = 1;
        for (int i = 1; i <= k; i++) {
            res = res * (n - k + i) / i;
        }
        return (int) (res % MOD);
    }
}