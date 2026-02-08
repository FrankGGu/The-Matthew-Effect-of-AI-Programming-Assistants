class Solution {
    public long countPairs(int n, int[][] edges) {
        UnionFind uf = new UnionFind(n);
        for (int[] edge : edges) {
            uf.union(edge[0], edge[1]);
        }
        Map<Integer, Integer> componentSizes = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int root = uf.find(i);
            componentSizes.put(root, componentSizes.getOrDefault(root, 0) + 1);
        }
        long totalPairs = (long) n * (n - 1) / 2;
        for (int size : componentSizes.values()) {
            totalPairs -= (long) size * (size - 1) / 2;
        }
        return totalPairs;
    }

    class UnionFind {
        private int[] parent;
        private int[] rank;

        public UnionFind(int size) {
            parent = new int[size];
            rank = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
                rank[i] = 1;
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
                if (rank[rootX] > rank[rootY]) {
                    parent[rootY] = rootX;
                    rank[rootX] += rank[rootY];
                } else {
                    parent[rootX] = rootY;
                    rank[rootY] += rank[rootX];
                }
            }
        }
    }
}