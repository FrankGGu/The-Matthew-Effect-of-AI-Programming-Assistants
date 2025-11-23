import java.util.*;

class Solution {
    class UnionFind {
        int[] parent;
        int[] rank;

        UnionFind(int n) {
            parent = new int[n + 1];
            rank = new int[n + 1];
            for (int i = 0; i <= n; i++) {
                parent[i] = i;
                rank[i] = 1;
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

    public int[] distance(int n, int[][] roads, int[][] queries) {
        UnionFind uf = new UnionFind(n);
        List<Integer> result = new ArrayList<>();
        int[][] distance = new int[n + 1][n + 1];
        for (int[] road : roads) {
            int u = road[0], v = road[1], w = road[2];
            uf.union(u, v);
            distance[u][v] = Math.min(distance[u][v] == 0 ? Integer.MAX_VALUE : distance[u][v], w);
            distance[v][u] = Math.min(distance[v][u] == 0 ? Integer.MAX_VALUE : distance[v][u], w);
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                if (distance[i][j] != 0) {
                    int rootI = uf.find(i);
                    int rootJ = uf.find(j);
                    if (rootI == rootJ) {
                        distance[rootI][rootJ] = Math.min(distance[rootI][rootJ], distance[i][j]);
                    }
                }
            }
        }

        for (int[] query : queries) {
            int u = query[0], v = query[1];
            if (uf.find(u) == uf.find(v)) {
                result.add(0);
            } else {
                result.add(-1);
            }
        }

        return result.stream().mapToInt(i -> i).toArray();
    }
}