class Solution {
    public int maxNumEdgesToRemove(int n, int[][] edges) {
        int[] parentA = new int[n + 1];
        int[] parentB = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            parentA[i] = i;
            parentB[i] = i;
        }

        int edgesRemoved = 0;
        int edgesAdded = 0;

        for (int[] edge : edges) {
            if (edge[0] == 3) {
                int u = edge[1];
                int v = edge[2];
                if (union(parentA, u, v)) {
                    union(parentB, u, v);
                    edgesAdded++;
                } else {
                    edgesRemoved++;
                }
            }
        }

        int aliceEdges = edgesAdded;
        int bobEdges = edgesAdded;

        for (int[] edge : edges) {
            if (edge[0] == 1) {
                int u = edge[1];
                int v = edge[2];
                if (union(parentA, u, v)) {
                    aliceEdges++;
                } else {
                    edgesRemoved++;
                }
            } else if (edge[0] == 2) {
                int u = edge[1];
                int v = edge[2];
                if (union(parentB, u, v)) {
                    bobEdges++;
                } else {
                    edgesRemoved++;
                }
            }
        }

        if (aliceEdges == n - 1 && bobEdges == n - 1) {
            return edgesRemoved;
        } else {
            return -1;
        }
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private boolean union(int[] parent, int u, int v) {
        int rootU = find(parent, u);
        int rootV = find(parent, v);
        if (rootU != rootV) {
            parent[rootU] = rootV;
            return true;
        }
        return false;
    }
}