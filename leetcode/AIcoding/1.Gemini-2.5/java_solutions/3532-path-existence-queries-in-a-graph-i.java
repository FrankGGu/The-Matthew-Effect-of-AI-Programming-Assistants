class Solution {
    private int[] parent;

    private void initDSU(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);
        if (rootI != rootJ) {
            parent[rootI] = rootJ;
        }
    }

    public boolean[] checkIfPathExists(int n, int[][] edges, int[][] queries) {
        initDSU(n);

        for (int[] edge : edges) {
            union(edge[0], edge[1]);
        }

        boolean[] result = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            result[i] = (find(u) == find(v));
        }

        return result;
    }
}