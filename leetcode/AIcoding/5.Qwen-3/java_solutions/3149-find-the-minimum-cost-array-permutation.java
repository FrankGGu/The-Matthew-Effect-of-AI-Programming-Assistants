public class Solution {

import java.util.*;

public class Solution {
    public int minCostArrayPermutation(int[] A) {
        int n = A.length;
        List<int[]> edges = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    edges.add(new int[]{i, j, Math.abs(A[i] - A[j])});
                }
            }
        }

        Collections.sort(edges, (a, b) -> a[2] - b[2]);

        UnionFind uf = new UnionFind(n);
        int totalCost = 0;

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int cost = edge[2];

            if (uf.find(u) != uf.find(v)) {
                uf.union(u, v);
                totalCost += cost;
            }
        }

        return totalCost;
    }

    static class UnionFind {
        int[] parent;

        public UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
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