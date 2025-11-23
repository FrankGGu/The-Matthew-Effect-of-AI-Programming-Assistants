public class Solution {

import java.util.*;

public class Solution {
    public boolean[] distanceLimitedPathsExist(int[][] p, int[][] queries) {
        int n = p.length;
        int m = queries.length;
        int[][] edges = new int[n][3];
        for (int i = 0; i < n; i++) {
            edges[i][0] = p[i][0];
            edges[i][1] = p[i][1];
            edges[i][2] = p[i][2];
        }
        Arrays.sort(edges, (a, b) -> a[2] - b[2]);
        int[][] q = new int[m][3];
        for (int i = 0; i < m; i++) {
            q[i][0] = queries[i][0];
            q[i][1] = queries[i][1];
            q[i][2] = i;
        }
        Arrays.sort(q, (a, b) -> a[2] - b[2]);
        UnionFind uf = new UnionFind(n);
        boolean[] res = new boolean[m];
        int edgeIdx = 0;
        for (int[] query : q) {
            int u = query[0];
            int v = query[1];
            int idx = query[2];
            while (edgeIdx < n && edges[edgeIdx][2] < query[2]) {
                uf.union(edges[edgeIdx][0], edges[edgeIdx][1]);
                edgeIdx++;
            }
            res[idx] = uf.find(u) == uf.find(v);
        }
        return res;
    }

    static class UnionFind {
        int[] parent;

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
                parent[rootX] = rootY;
            }
        }
    }
}
}