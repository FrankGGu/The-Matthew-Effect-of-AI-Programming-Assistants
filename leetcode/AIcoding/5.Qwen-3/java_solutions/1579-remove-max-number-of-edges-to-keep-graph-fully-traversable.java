public class Solution {

import java.util.*;

public class Solution {
    public int maxNumEdgesToRemove(int n, int[][] edges) {
        UnionFind uf1 = new UnionFind(n);
        UnionFind uf2 = new UnionFind(n);
        int count = 0;

        for (int[] edge : edges) {
            if (edge[0] == 1) {
                uf1.union(edge[1] - 1, edge[2] - 1);
            } else if (edge[0] == 2) {
                uf2.union(edge[1] - 1, edge[2] - 1);
            }
        }

        for (int[] edge : edges) {
            if (edge[0] == 1) {
                if (!uf1.union(edge[1] - 1, edge[2] - 1)) {
                    count++;
                }
            } else if (edge[0] == 2) {
                if (!uf2.union(edge[1] - 1, edge[2] - 1)) {
                    count++;
                }
            }
        }

        if (uf1.isConnected() && uf2.isConnected()) {
            return count;
        } else {
            return -1;
        }
    }

    static class UnionFind {
        private int[] parent;
        private int[] rank;
        private int components;

        public UnionFind(int n) {
            parent = new int[n];
            rank = new int[n];
            components = n;
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

        public boolean union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) {
                return false;
            }
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootX] = rootY;
                if (rank[rootX] == rank[rootY]) {
                    rank[rootY]++;
                }
            }
            components--;
            return true;
        }

        public boolean isConnected() {
            return components == 1;
        }
    }
}
}