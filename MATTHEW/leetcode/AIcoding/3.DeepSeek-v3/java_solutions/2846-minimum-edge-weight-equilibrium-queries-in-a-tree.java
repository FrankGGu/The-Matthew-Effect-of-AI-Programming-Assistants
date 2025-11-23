class Solution {
    private static final int MAX_LOG = 14;
    private int[][] parent;
    private int[] depth;
    private int[][] count;
    private List<int[]>[] tree;

    public int[] minEdgeQueries(int n, int[][] edges, int[][] queries) {
        tree = new List[n + 1];
        for (int i = 0; i <= n; i++) {
            tree[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            tree[u].add(new int[]{v, w});
            tree[v].add(new int[]{u, w});
        }

        parent = new int[n + 1][MAX_LOG];
        depth = new int[n + 1];
        count = new int[n + 1][27];
        dfs(1, 0, 0);

        for (int k = 1; k < MAX_LOG; k++) {
            for (int v = 1; v <= n; v++) {
                parent[v][k] = parent[parent[v][k - 1]][k - 1];
            }
        }

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0], v = queries[i][1];
            int lca = lca(u, v);
            int[] cnt = new int[27];
            for (int j = 1; j <= 26; j++) {
                cnt[j] = count[u][j] + count[v][j] - 2 * count[lca][j];
            }
            int total = 0, max = 0;
            for (int j = 1; j <= 26; j++) {
                total += cnt[j];
                max = Math.max(max, cnt[j]);
            }
            res[i] = total - max;
        }
        return res;
    }

    private void dfs(int u, int p, int d) {
        parent[u][0] = p;
        depth[u] = d;
        for (int[] edge : tree[u]) {
            int v = edge[0], w = edge[1];
            if (v != p) {
                System.arraycopy(count[u], 0, count[v], 0, 27);
                count[v][w]++;
                dfs(v, u, d + 1);
            }
        }
    }

    private int lca(int u, int v) {
        if (depth[u] < depth[v]) {
            int temp = u;
            u = v;
            v = temp;
        }
        for (int k = MAX_LOG - 1; k >= 0; k--) {
            if (depth[u] - (1 << k) >= depth[v]) {
                u = parent[u][k];
            }
        }
        if (u == v) {
            return u;
        }
        for (int k = MAX_LOG - 1; k >= 0; k--) {
            if (parent[u][k] != parent[v][k]) {
                u = parent[u][k];
                v = parent[v][k];
            }
        }
        return parent[u][0];
    }
}