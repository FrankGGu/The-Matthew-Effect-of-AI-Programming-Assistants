import java.util.Arrays;
import java.util.Comparator;

class Solution {
    private int[] parent;

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

    public boolean[] distanceLimitedPathsExist(int n, int[][] edgeList, int[][] queries) {
        Arrays.sort(edgeList, Comparator.comparingInt(a -> a[2]));

        int[][] sortedQueries = new int[queries.length][4];
        for (int i = 0; i < queries.length; i++) {
            sortedQueries[i][0] = queries[i][0];
            sortedQueries[i][1] = queries[i][1];
            sortedQueries[i][2] = queries[i][2];
            sortedQueries[i][3] = i;
        }
        Arrays.sort(sortedQueries, Comparator.comparingInt(a -> a[2]));

        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        boolean[] results = new boolean[queries.length];
        int edgeIdx = 0;

        for (int[] query : sortedQueries) {
            int u = query[0];
            int v = query[1];
            int limit = query[2];
            int originalIdx = query[3];

            while (edgeIdx < edgeList.length && edgeList[edgeIdx][2] < limit) {
                union(edgeList[edgeIdx][0], edgeList[edgeIdx][1]);
                edgeIdx++;
            }

            results[originalIdx] = (find(u) == find(v));
        }

        return results;
    }
}