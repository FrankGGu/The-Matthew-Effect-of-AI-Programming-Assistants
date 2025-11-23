import java.util.*;

public class Solution {
    public int[] findRedundantDirectedConnection(int[][] edges) {
        int n = edges.length;
        int[] parent = new int[n + 1];
        Arrays.fill(parent, -1);
        int[] edge1 = null, edge2 = null;

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            if (parent[v] != -1) {
                edge2 = edge;
                edge1 = new int[]{parent[v], v};
                edge[1] = -1; // Temporarily remove this edge
                break;
            }
            parent[v] = u;
        }

        if (edge2 == null) {
            return findRedundantEdge(edges);
        }

        UnionFind uf = new UnionFind(n);
        for (int[] edge : edges) {
            if (edge[1] == -1) continue;
            if (!uf.union(edge[0], edge[1])) {
                return edge;
            }
        }

        return edge1;
    }

    private int[] findRedundantEdge(int[][] edges) {
        UnionFind uf = new UnionFind(edges.length);
        for (int[] edge : edges) {
            if (!uf.union(edge[0], edge[1])) {
                return edge;
            }
        }
        return null;
    }

    class UnionFind {
        private int[] parent;

        public UnionFind(int size) {
            parent = new int[size + 1];
            for (int i = 0; i <= size; i++) {
                parent[i] = i;
            }
        }

        public int find(int node) {
            if (parent[node] != node) {
                parent[node] = find(parent[node]);
            }
            return parent[node];
        }

        public boolean union(int u, int v) {
            int rootU = find(u);
            int rootV = find(v);
            if (rootU == rootV) return false;
            parent[rootU] = rootV;
            return true;
        }
    }
}