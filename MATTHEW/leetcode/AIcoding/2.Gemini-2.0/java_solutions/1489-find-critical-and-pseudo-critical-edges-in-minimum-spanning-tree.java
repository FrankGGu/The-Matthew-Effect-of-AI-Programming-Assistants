import java.util.*;

class Solution {
    public List<List<Integer>> findCriticalAndPseudoCriticalEdges(int n, int[][] edges) {
        int m = edges.length;
        int[][] newEdges = new int[m][4];
        for (int i = 0; i < m; i++) {
            newEdges[i][0] = edges[i][0];
            newEdges[i][1] = edges[i][1];
            newEdges[i][2] = edges[i][2];
            newEdges[i][3] = i;
        }
        Arrays.sort(newEdges, (a, b) -> a[2] - b[2]);

        int mstWeight = getMSTWeight(n, newEdges, -1, -1);

        List<Integer> criticalEdges = new ArrayList<>();
        List<Integer> pseudoCriticalEdges = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            if (getMSTWeight(n, newEdges, i, -1) > mstWeight) {
                criticalEdges.add(newEdges[i][3]);
            } else if (getMSTWeight(n, newEdges, -1, i) == mstWeight) {
                pseudoCriticalEdges.add(newEdges[i][3]);
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        result.add(criticalEdges);
        result.add(pseudoCriticalEdges);

        return result;
    }

    private int getMSTWeight(int n, int[][] edges, int excludeEdgeIndex, int includeEdgeIndex) {
        int weight = 0;
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        int edgesUsed = 0;

        if (includeEdgeIndex != -1) {
            int u = edges[includeEdgeIndex][0];
            int v = edges[includeEdgeIndex][1];
            int w = edges[includeEdgeIndex][2];
            if (union(parent, u, v)) {
                weight += w;
                edgesUsed++;
            }
        }

        for (int i = 0; i < edges.length; i++) {
            if (i == excludeEdgeIndex) {
                continue;
            }

            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];

            if (union(parent, u, v)) {
                weight += w;
                edgesUsed++;
            }
        }

        if (edgesUsed != n - 1) {
            return Integer.MAX_VALUE;
        }

        return weight;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private boolean union(int[] parent, int i, int j) {
        int rootI = find(parent, i);
        int rootJ = find(parent, j);
        if (rootI != rootJ) {
            parent[rootI] = rootJ;
            return true;
        }
        return false;
    }
}