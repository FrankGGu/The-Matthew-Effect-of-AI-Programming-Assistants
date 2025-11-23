class Solution {
    static class DSU {
        int[] parent;
        int[] rank;

        public DSU(int n) {
            parent = new int[n + 1];
            rank = new int[n + 1];
            for (int i = 1; i <= n; i++) {
                parent[i] = i;
                rank[i] = 1;
            }
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

            if (rootI == rootJ) {
                return false;
            }

            if (rank[rootI] < rank[rootJ]) {
                parent[rootI] = rootJ;
            } else if (rank[rootJ] < rank[rootI]) {
                parent[rootJ] = rootI;
            } else {
                parent[rootJ] = rootI;
                rank[rootI]++;
            }
            return true;
        }
    }

    private boolean checkCycle(int n, int[][] edges, int[] skipEdge) {
        DSU dsu = new DSU(n);
        for (int[] edge : edges) {
            if (edge[0] == skipEdge[0] && edge[1] == skipEdge[1]) {
                continue;
            }
            if (!dsu.union(edge[0], edge[1])) {
                return true;
            }
        }
        return false;
    }

    public int[] findRedundantDirectedConnection(int[][] edges) {
        int n = edges.length;

        int[] parent = new int[n + 1];
        int[] candidate1 = null;
        int[] candidate2 = null;

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            if (parent[v] != 0) {
                candidate1 = new int[]{parent[v], v};
                candidate2 = edge;
            } else {
                parent[v] = u;
            }
        }

        if (candidate1 != null) {
            if (checkCycle(n, edges, candidate2)) {
                return candidate1;
            } else {
                return candidate2;
            }
        } else {
            DSU dsu = new DSU(n);
            for (int[] edge : edges) {
                if (!dsu.union(edge[0], edge[1])) {
                    return edge;
                }
            }
        }
        return new int[0];
    }
}