class Solution {
    public int[] minimumCost(int n, int[][] edges, int[][] queries) {
        int[] parent = new int[n];
        int[] rank = new int[n];
        int[] minCost = new int[n];
        Arrays.fill(minCost, Integer.MAX_VALUE);

        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int cost = edge[2];
            union(u, v, parent, rank, minCost, cost);
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            if (u == v) {
                result[i] = 0;
                continue;
            }
            int rootU = find(u, parent);
            int rootV = find(v, parent);
            if (rootU != rootV) {
                result[i] = -1;
            } else {
                result[i] = minCost[rootU];
            }
        }
        return result;
    }

    private int find(int u, int[] parent) {
        if (parent[u] != u) {
            parent[u] = find(parent[u], parent);
        }
        return parent[u];
    }

    private void union(int u, int v, int[] parent, int[] rank, int[] minCost, int cost) {
        int rootU = find(u, parent);
        int rootV = find(v, parent);
        if (rootU == rootV) {
            minCost[rootU] &= cost;
            return;
        }
        if (rank[rootU] > rank[rootV]) {
            parent[rootV] = rootU;
            minCost[rootU] &= minCost[rootV] & cost;
        } else if (rank[rootU] < rank[rootV]) {
            parent[rootU] = rootV;
            minCost[rootV] &= minCost[rootU] & cost;
        } else {
            parent[rootV] = rootU;
            rank[rootU]++;
            minCost[rootU] &= minCost[rootV] & cost;
        }
    }
}