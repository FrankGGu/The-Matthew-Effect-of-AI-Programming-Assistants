class Solution {
    public List<Boolean> validPath(int n, int[][] edges, List<List<Integer>> queries) {
        UnionFind uf = new UnionFind(n);
        for (int[] edge : edges) {
            uf.union(edge[0], edge[1]);
        }
        List<Boolean> result = new ArrayList<>();
        for (List<Integer> query : queries) {
            result.add(uf.connected(query.get(0), query.get(1)));
        }
        return result;
    }

    class UnionFind {
        private int[] parent;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        }

        public boolean connected(int x, int y) {
            return find(x) == find(y);
        }
    }
}