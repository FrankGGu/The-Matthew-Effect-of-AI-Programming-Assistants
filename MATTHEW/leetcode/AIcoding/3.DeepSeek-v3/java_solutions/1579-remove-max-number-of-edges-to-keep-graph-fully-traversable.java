class Solution {
    public int maxNumEdgesToRemove(int n, int[][] edges) {
        UnionFind alice = new UnionFind(n);
        UnionFind bob = new UnionFind(n);
        int res = 0;

        for (int[] edge : edges) {
            if (edge[0] == 3) {
                boolean a = alice.union(edge[1] - 1, edge[2] - 1);
                boolean b = bob.union(edge[1] - 1, edge[2] - 1);
                if (!a && !b) {
                    res++;
                }
            }
        }

        for (int[] edge : edges) {
            if (edge[0] == 1) {
                if (!alice.union(edge[1] - 1, edge[2] - 1)) {
                    res++;
                }
            } else if (edge[0] == 2) {
                if (!bob.union(edge[1] - 1, edge[2] - 1)) {
                    res++;
                }
            }
        }

        if (alice.getCount() != 1 || bob.getCount() != 1) {
            return -1;
        }

        return res;
    }

    class UnionFind {
        private int[] parent;
        private int[] rank;
        private int count;

        public UnionFind(int n) {
            parent = new int[n];
            rank = new int[n];
            count = n;
            for (int i = 0; i < n; i++) {
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

        public boolean union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) {
                return false;
            }
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
            count--;
            return true;
        }

        public int getCount() {
            return count;
        }
    }
}