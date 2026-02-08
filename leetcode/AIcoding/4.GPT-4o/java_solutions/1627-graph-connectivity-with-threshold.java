class Solution {
    public boolean areConnected(int n, int threshold, int u, int v) {
        if (threshold < 1) return false;
        UnionFind uf = new UnionFind(n);
        for (int i = threshold + 1; i <= n; i++) {
            for (int j = 2 * i; j <= n; j += i) {
                uf.union(i, j);
            }
        }
        return uf.find(u) == uf.find(v);
    }

    class UnionFind {
        int[] parent;

        UnionFind(int n) {
            parent = new int[n + 1];
            for (int i = 0; i <= n; i++) {
                parent[i] = i;
            }
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        }
    }
}