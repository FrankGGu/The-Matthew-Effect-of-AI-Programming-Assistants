class Solution {
    public int makeConnected(int n, int[][] connections) {
        if (connections.length < n - 1) {
            return -1;
        }

        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        int components = n;
        for (int[] connection : connections) {
            int u = connection[0];
            int v = connection[1];
            int rootU = find(parent, u);
            int rootV = find(parent, v);
            if (rootU != rootV) {
                parent[rootU] = rootV;
                components--;
            }
        }

        return components - 1;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}