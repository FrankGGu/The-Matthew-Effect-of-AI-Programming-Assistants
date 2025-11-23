class Solution {
    class UnionFind {
        int[] parent;
        int count;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
            count = n;
        }

        public int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        public boolean union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);

            if (rootI != rootJ) {
                parent[rootI] = rootJ;
                count--;
                return true;
            }
            return false;
        }

        public int getCount() {
            return count;
        }
    }

    public int makeConnected(int n, int[][] connections) {
        if (n == 1) {
            return 0;
        }
        if (connections.length < n - 1) {
            return -1;
        }

        UnionFind uf = new UnionFind(n);
        int redundantCables = 0;

        for (int[] connection : connections) {
            int u = connection[0];
            int v = connection[1];

            if (!uf.union(u, v)) {
                redundantCables++;
            }
        }

        if (redundantCables >= uf.getCount() - 1) {
            return uf.getCount() - 1;
        } else {
            return -1;
        }
    }
}