public class Solution {

import java.util.*;

public class Solution {
    public int[] findMinMaxEdge(int n, int[][] edges, int q, int[][] queries) {
        Arrays.sort(queries, (a, b) -> a[0] - b[0]);
        Arrays.sort(edges, (a, b) -> a[2] - b[2]);

        UnionFind uf = new UnionFind(n);
        int[] result = new int[q];
        int edgeIndex = 0;

        for (int i = 0; i < q; i++) {
            int limit = queries[i][0];
            int index = queries[i][1];

            while (edgeIndex < edges.length && edges[edgeIndex][2] <= limit) {
                uf.union(edges[edgeIndex][0], edges[edgeIndex][1]);
                edgeIndex++;
            }

            result[index] = uf.find(0);
        }

        return result;
    }

    private class UnionFind {
        private int[] parent;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        }
    }
}
}