import java.util.ArrayList;
import java.util.List;

public class Solution {
    public int maxNumEdgesToRemove(int n, int[][] edges) {
        UnionFind ufA = new UnionFind(n);
        UnionFind ufB = new UnionFind(n);

        int totalEdges = 0;

        for (int[] edge : edges) {
            if (edge[0] == 1) {
                totalEdges += ufA.union(edge[1] - 1, edge[2] - 1) ? 1 : 0;
            } else if (edge[0] == 2) {
                totalEdges += ufB.union(edge[1] - 1, edge[2] - 1) ? 1 : 0;
            }
        }

        int commonEdges = 0;
        for (int[] edge : edges) {
            if (edge[0] == 3) {
                commonEdges += ufA.union(edge[1] - 1, edge[2] - 1) ? 1 : 0;
            }
        }

        if (ufA.getCount() > 1 || ufB.getCount() > 1) return -1;

        return edges.length - (totalEdges + commonEdges);
    }
}

class UnionFind {
    private int[] parent;
    private int[] rank;
    private int count;

    public UnionFind(int size) {
        parent = new int[size];
        rank = new int[size];
        for (int i = 0; i < size; i++) {
            parent[i] = i;
            rank[i] = 1;
        }
        count = size;
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

        if (rootX == rootY) return false;

        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
        count--;
        return true;
    }

    public int getCount() {
        return count;
    }
}