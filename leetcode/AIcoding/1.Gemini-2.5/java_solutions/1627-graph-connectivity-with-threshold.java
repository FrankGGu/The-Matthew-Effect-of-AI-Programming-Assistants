import java.util.ArrayList;
import java.util.List;

class UnionFind {
    private int[] parent;
    private int[] rank;

    public UnionFind(int n) {
        parent = new int[n + 1];
        rank = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            parent[i] = i;
            rank[i] = 0;
        }
    }

    public int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    public void union(int i, int j) {
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

class Solution {
    public List<Boolean> areConnected(int n, int threshold, int[][] queries) {
        UnionFind uf = new UnionFind(n);

        for (int g = threshold + 1; g <= n; g++) {
            for (int multiple = 2 * g; multiple <= n; multiple += g) {
                uf.union(g, multiple);
            }
        }

        List<Boolean> result = new ArrayList<>();
        for (int[] query : queries) {
            int u = query[0];
            int v = query[1];
            result.add(uf.find(u) == uf.find(v));
        }

        return result;
    }
}