class Solution {
    private List<List<Integer>> tree;
    private int[] parent;
    private int[] size;
    private boolean[] removed;

    public int[] subtreeSizesAfterChanges(int n, int[][] edges, int[][] queries) {
        tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            tree.get(u).add(v);
            tree.get(v).add(u);
        }

        parent = new int[n];
        size = new int[n];
        removed = new boolean[n];
        Arrays.fill(parent, -1);
        dfs(0, -1);

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int node = queries[i][0];
            int type = queries[i][1];
            if (type == 1) {
                removed[node] = true;
                int p = parent[node];
                while (p != -1) {
                    size[p] -= size[node];
                    p = parent[p];
                }
            } else if (type == 2) {
                removed[node] = false;
                int p = parent[node];
                int prevSize = size[node];
                size[node] = 1;
                for (int child : tree.get(node)) {
                    if (child != parent[node] && !removed[child]) {
                        size[node] += size[child];
                    }
                }
                int delta = size[node] - prevSize;
                p = parent[node];
                while (p != -1) {
                    size[p] += delta;
                    p = parent[p];
                }
            }
            res[i] = size[0];
        }
        return res;
    }

    private void dfs(int u, int p) {
        parent[u] = p;
        size[u] = 1;
        for (int v : tree.get(u)) {
            if (v != p) {
                dfs(v, u);
                size[u] += size[v];
            }
        }
    }
}