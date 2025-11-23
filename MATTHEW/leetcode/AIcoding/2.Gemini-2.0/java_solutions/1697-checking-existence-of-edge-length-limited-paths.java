import java.util.Arrays;

class Solution {
    public boolean[] distanceLimitedPathsExist(int n, int[][] edgeList, int[][] queries) {
        int q = queries.length;
        boolean[] res = new boolean[q];
        int[][] indexedQueries = new int[q][4];
        for (int i = 0; i < q; i++) {
            indexedQueries[i][0] = queries[i][0];
            indexedQueries[i][1] = queries[i][1];
            indexedQueries[i][2] = queries[i][2];
            indexedQueries[i][3] = i;
        }
        Arrays.sort(edgeList, (a, b) -> a[2] - b[2]);
        Arrays.sort(indexedQueries, (a, b) -> a[2] - b[2]);

        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        int edgeIndex = 0;
        for (int i = 0; i < q; i++) {
            int p = indexedQueries[i][0];
            int qry = indexedQueries[i][1];
            int limit = indexedQueries[i][2];
            int index = indexedQueries[i][3];

            while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
                int u = edgeList[edgeIndex][0];
                int v = edgeList[edgeIndex][1];
                union(u, v, parent);
                edgeIndex++;
            }

            res[index] = find(p, parent) == find(qry, parent);
        }

        return res;
    }

    private int find(int x, int[] parent) {
        if (parent[x] == x) {
            return x;
        }
        return parent[x] = find(parent[x], parent);
    }

    private void union(int x, int y, int[] parent) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }
}