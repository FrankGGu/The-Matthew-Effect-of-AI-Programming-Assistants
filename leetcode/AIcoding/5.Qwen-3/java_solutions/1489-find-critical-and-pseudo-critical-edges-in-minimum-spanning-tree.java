public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findCriticalAndPseudoCriticalEdges(int n, int[][] edges) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> critical = new ArrayList<>();
        List<Integer> pseudoCritical = new ArrayList<>();

        int m = edges.length;
        int[][] newEdges = new int[m][4];
        for (int i = 0; i < m; i++) {
            newEdges[i][0] = edges[i][0];
            newEdges[i][1] = edges[i][1];
            newEdges[i][2] = edges[i][2];
            newEdges[i][3] = i;
        }

        Arrays.sort(newEdges, (a, b) -> a[2] - b[2]);

        int mstWeight = kruskal(n, newEdges, -1, -1);

        for (int i = 0; i < m; i++) {
            int weight = kruskal(n, newEdges, i, -1);
            if (weight != mstWeight) {
                critical.add(i);
            } else {
                int weightWithEdge = kruskal(n, newEdges, -1, i);
                if (weightWithEdge == mstWeight) {
                    pseudoCritical.add(i);
                }
            }
        }

        result.add(critical);
        result.add(pseudoCritical);
        return result;
    }

    private int kruskal(int n, int[][] edges, int excludeEdge, int includeEdge) {
        UnionFind uf = new UnionFind(n);
        int weight = 0;
        int count = 0;

        if (includeEdge != -1) {
            int[] edge = edges[includeEdge];
            uf.union(edge[0], edge[1]);
            weight += edge[2];
            count++;
        }

        for (int i = 0; i < edges.length; i++) {
            if (i == excludeEdge) continue;
            int[] edge = edges[i];
            if (uf.find(edge[0]) != uf.find(edge[1])) {
                uf.union(edge[0], edge[1]);
                weight += edge[2];
                count++;
            }
        }

        return count == n - 1 ? weight : Integer.MAX_VALUE;
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
                parent[rootY] = rootX;
            }
        }
    }
}
}