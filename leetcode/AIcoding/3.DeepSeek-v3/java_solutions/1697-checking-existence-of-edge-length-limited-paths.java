class Solution {
    private int[] parent;
    private int[] rank;

    public boolean[] distanceLimitedPathsExist(int n, int[][] edgeList, int[][] queries) {
        parent = new int[n];
        rank = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        int m = queries.length;
        int[][] indexedQueries = new int[m][4];
        for (int i = 0; i < m; i++) {
            indexedQueries[i][0] = queries[i][0];
            indexedQueries[i][1] = queries[i][1];
            indexedQueries[i][2] = queries[i][2];
            indexedQueries[i][3] = i;
        }

        Arrays.sort(edgeList, (a, b) -> a[2] - b[2]);
        Arrays.sort(indexedQueries, (a, b) -> a[2] - b[2]);

        boolean[] res = new boolean[m];
        int edgeIndex = 0;
        for (int[] query : indexedQueries) {
            int u = query[0];
            int v = query[1];
            int limit = query[2];
            int originalIndex = query[3];

            while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
                int x = edgeList[edgeIndex][0];
                int y = edgeList[edgeIndex][1];
                union(x, y);
                edgeIndex++;
            }

            res[originalIndex] = find(u) == find(v);
        }

        return res;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }
}