public class Solution {

import java.util.*;

public class Solution {
    public List<Boolean> areConnected(int n, int threshold, int[][] queries) {
        UnionFind uf = new UnionFind(n);
        for (int i = threshold + 1; i <= n; i++) {
            for (int j = 2 * i; j <= n; j += i) {
                uf.union(i - 1, j - 1);
            }
        }
        List<Boolean> result = new ArrayList<>();
        for (int[] query : queries) {
            int u = query[0] - 1;
            int v = query[1] - 1;
            result.add(uf.find(u) == uf.find(v));
        }
        return result;
    }

    private static class UnionFind {
        private int[] parent;

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