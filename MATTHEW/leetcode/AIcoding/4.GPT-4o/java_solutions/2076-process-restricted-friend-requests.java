import java.util.*;

public class Solution {
    public int[] numOfRequests(int n, int[][] requests) {
        int[] result = new int[requests.length];
        UnionFind uf = new UnionFind(n);

        for (int i = 0; i < requests.length; i++) {
            uf.reset();
            int count = 0;
            for (int j = 0; j <= i; j++) {
                int u = requests[j][0];
                int v = requests[j][1];
                if (uf.find(u) != uf.find(v)) {
                    uf.union(u, v);
                    count++;
                }
            }
            result[i] = count;
        }

        return result;
    }

    class UnionFind {
        int[] parent, rank;

        public UnionFind(int size) {
            parent = new int[size];
            rank = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
                rank[i] = 1;
            }
        }

        public int find(int u) {
            if (parent[u] != u) {
                parent[u] = find(parent[u]);
            }
            return parent[u];
        }

        public void union(int u, int v) {
            int rootU = find(u);
            int rootV = find(v);
            if (rootU != rootV) {
                if (rank[rootU] > rank[rootV]) {
                    parent[rootV] = rootU;
                } else if (rank[rootU] < rank[rootV]) {
                    parent[rootU] = rootV;
                } else {
                    parent[rootV] = rootU;
                    rank[rootU]++;
                }
            }
        }

        public void reset() {
            for (int i = 0; i < parent.length; i++) {
                parent[i] = i;
                rank[i] = 1;
            }
        }
    }
}