class Solution {
    public boolean[] distanceLimitedPathsExist(int n, int[][] edgeList, int[][] queries) {
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        Arrays.sort(edgeList, (a, b) -> a[2] - b[2]);

        int[][] indexedQueries = new int[queries.length][4];
        for (int i = 0; i < queries.length; i++) {
            indexedQueries[i][0] = queries[i][0];
            indexedQueries[i][1] = queries[i][1];
            indexedQueries[i][2] = queries[i][2];
            indexedQueries[i][3] = i;
        }
        Arrays.sort(indexedQueries, (a, b) -> a[2] - b[2]);

        boolean[] result = new boolean[queries.length];
        int edgeIndex = 0;
        for (int[] query : indexedQueries) {
            int u = query[0];
            int v = query[1];
            int limit = query[2];
            int originalIndex = query[3];

            while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
                int x = edgeList[edgeIndex][0];
                int y = edgeList[edgeIndex][1];
                union(parent, x, y);
                edgeIndex++;
            }

            result[originalIndex] = find(parent, u) == find(parent, v);
        }

        return result;
    }

    private int find(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }

    private void union(int[] parent, int x, int y) {
        int rootX = find(parent, x);
        int rootY = find(parent, y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }
}