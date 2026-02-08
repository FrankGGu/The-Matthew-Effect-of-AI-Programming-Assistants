class Solution {
    private int[] parent;
    private int[] componentAndValue;
    private boolean[] hasEdge;

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private void union(int u, int v, int w) {
        int rootU = find(u);
        int rootV = find(v);

        if (rootU != rootV) {
            parent[rootV] = rootU;
            componentAndValue[rootU] = componentAndValue[rootU] & componentAndValue[rootV] & w;
        } else {
            componentAndValue[rootU] = componentAndValue[rootU] & w;
        }
    }

    public int[] minimumCost(int n, int[][] edges, int[][] queries) {
        parent = new int[n];
        componentAndValue = new int[n];
        hasEdge = new boolean[n];

        for (int i = 0; i < n; i++) {
            parent[i] = i;
            componentAndValue[i] = Integer.MAX_VALUE; 
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            union(u, v, w);
            hasEdge[u] = true;
            hasEdge[v] = true;
        }

        int[] results = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int s = queries[i][0];
            int t = queries[i][1];

            if (s == t) {
                if (!hasEdge[s]) {
                    results[i] = -1;
                } else {
                    results[i] = componentAndValue[find(s)];
                }
            } else {
                int rootS = find(s);
                int rootT = find(t);
                if (rootS == rootT) {
                    results[i] = componentAndValue[rootS];
                } else {
                    results[i] = -1;
                }
            }
        }

        return results;
    }
}