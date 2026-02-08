import java.util.*;

class Solution {
    class UnionFind {
        int[] parent;
        int[] rank;

        UnionFind(int size) {
            parent = new int[size];
            rank = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
            }
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                if (rank[rootX] > rank[rootY]) {
                    parent[rootY] = rootX;
                } else if (rank[rootX] < rank[rootY]) {
                    parent[rootX] = rootY;
                } else {
                    parent[rootY] = rootX;
                    rank[rootX]++;
                }
            }
        }
    }

    public boolean[] distanceLimitedPathsExist(int n, int[][] edgeList, int[][] queries) {
        int m = queries.length;
        boolean[] result = new boolean[m];
        int[][] indexedQueries = new int[m][3];

        for (int i = 0; i < m; i++) {
            indexedQueries[i] = new int[]{queries[i][0], queries[i][1], queries[i][2], i};
        }

        Arrays.sort(edgeList, (a, b) -> Integer.compare(a[2], b[2]));
        Arrays.sort(indexedQueries, (a, b) -> Integer.compare(a[2], b[2]));

        UnionFind uf = new UnionFind(n);
        int edgeIndex = 0;

        for (int[] query : indexedQueries) {
            int u = query[0], v = query[1], limit = query[2], queryIndex = query[3];

            while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
                uf.union(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
                edgeIndex++;
            }

            result[queryIndex] = uf.find(u) == uf.find(v);
        }

        return result;
    }
}