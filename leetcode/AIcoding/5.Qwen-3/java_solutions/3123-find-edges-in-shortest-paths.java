public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findCriticalAndPseudoCriticalEdges(int n, int[][] edges) {
        int m = edges.length;
        int[][] graph = new int[m][4];

        for (int i = 0; i < m; i++) {
            graph[i][0] = edges[i][0];
            graph[i][1] = edges[i][1];
            graph[i][2] = edges[i][2];
            graph[i][3] = i;
        }

        Arrays.sort(graph, (a, b) -> a[2] - b[2]);

        int[] originalMST = kruskal(n, graph, -1, -1);
        int originalWeight = originalMST[0];

        List<List<Integer>> result = new ArrayList<>();
        result.add(new ArrayList<>());
        result.add(new ArrayList<>());

        for (int i = 0; i < m; i++) {
            int[] mstWithout = kruskal(n, graph, i, -1);
            if (mstWithout[0] != originalWeight) {
                result.get(0).add(i);
            } else {
                int[] mstWith = kruskal(n, graph, -1, i);
                if (mstWith[0] == originalWeight) {
                    result.get(1).add(i);
                }
            }
        }

        return result;
    }

    private int[] kruskal(int n, int[][] edges, int excludeIndex, int includeIndex) {
        UnionFind uf = new UnionFind(n);
        int weight = 0;
        int count = 0;

        if (includeIndex != -1) {
            int[] edge = edges[includeIndex];
            uf.union(edge[0], edge[1]);
            weight += edge[2];
            count++;
        }

        for (int i = 0; i < edges.length; i++) {
            if (i == excludeIndex) continue;
            int[] edge = edges[i];
            if (uf.find(edge[0]) != uf.find(edge[1])) {
                uf.union(edge[0], edge[1]);
                weight += edge[2];
                count++;
            }
        }

        if (count == n - 1) {
            return new int[]{weight, count};
        } else {
            return new int[]{Integer.MAX_VALUE, count};
        }
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
                parent[rootX] = rootY;
            }
        }
    }
}
}