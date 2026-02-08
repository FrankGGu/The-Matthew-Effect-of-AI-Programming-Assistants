import java.util.Arrays;

class Solution {
    class DSU {
        int[] parent;
        int[] rank;

        DSU(int n) {
            parent = new int[n];
            rank = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
                rank[i] = 0;
            }
        }

        int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);

            if (rootI != rootJ) {
                if (rank[rootI] < rank[rootJ]) {
                    parent[rootI] = rootJ;
                } else if (rank[rootJ] < rank[rootI]) {
                    parent[rootJ] = rootI;
                } else {
                    parent[rootJ] = rootI;
                    rank[rootI]++;
                }
            }
        }
    }

    public boolean[] distanceLimitedPathsExist(int n, int[][] edgeList, int[][] queries) {
        int[][] indexedQueries = new int[queries.length][4];
        for (int i = 0; i < queries.length; i++) {
            indexedQueries[i][0] = queries[i][0];
            indexedQueries[i][1] = queries[i][1];
            indexedQueries[i][2] = queries[i][2];
            indexedQueries[i][3] = i;
        }

        Arrays.sort(edgeList, (a, b) -> a[2] - b[2]);
        Arrays.sort(indexedQueries, (a, b) -> a[2] - b[2]);

        DSU dsu = new DSU(n);
        boolean[] results = new boolean[queries.length];

        int edgeIndex = 0;
        for (int[] query : indexedQueries) {
            int p = query[0];
            int q = query[1];
            int limit = query[2];
            int originalIndex = query[3];

            while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
                dsu.union(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
                edgeIndex++;
            }

            results[originalIndex] = (dsu.find(p) == dsu.find(q));
        }

        return results;
    }
}