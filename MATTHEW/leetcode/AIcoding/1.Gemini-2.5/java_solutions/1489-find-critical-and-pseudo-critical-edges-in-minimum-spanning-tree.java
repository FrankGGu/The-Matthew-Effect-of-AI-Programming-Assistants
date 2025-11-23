import java.util.*;

class Solution {
    class DSU {
        int[] parent;
        int[] rank;

        public DSU(int n) {
            parent = new int[n];
            rank = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        public boolean union(int i, int j) {
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
                return true;
            }
            return false;
        }
    }

    private int kruskal(int n, List<int[]> edges, int excludeEdgeIdx, int includeEdgeIdx) {
        DSU dsu = new DSU(n);
        int mstWeight = 0;
        int edgesCount = 0;

        if (includeEdgeIdx != -1) {
            int[] edge = edges.get(includeEdgeIdx);
            if (dsu.union(edge[0], edge[1])) {
                mstWeight += edge[2];
                edgesCount++;
            } else {
                return Integer.MAX_VALUE;
            }
        }

        for (int i = 0; i < edges.size(); i++) {
            if (i == excludeEdgeIdx || i == includeEdgeIdx) {
                continue;
            }

            int[] edge = edges.get(i);
            if (dsu.union(edge[0], edge[1])) {
                mstWeight += edge[2];
                edgesCount++;
            }
        }

        if (edgesCount == n - 1) {
            return mstWeight;
        } else {
            return Integer.MAX_VALUE;
        }
    }

    public List<List<Integer>> findCriticalAndPseudoCriticalEdges(int n, int[][] edges) {
        List<int[]> augmentedEdges = new ArrayList<>();
        for (int i = 0; i < edges.length; i++) {
            augmentedEdges.add(new int[]{edges[i][0], edges[i][1], edges[i][2], i});
        }

        augmentedEdges.sort(Comparator.comparingInt(a -> a[2]));

        int originalMstWeight = kruskal(n, augmentedEdges, -1, -1);

        List<Integer> criticalEdges = new ArrayList<>();
        List<Integer> pseudoCriticalEdges = new ArrayList<>();
        boolean[] isCritical = new boolean[edges.length];

        for (int i = 0; i < augmentedEdges.size(); i++) {
            int mstWeightWithoutCurrent = kruskal(n, augmentedEdges, i, -1);
            if (mstWeightWithoutCurrent > originalMstWeight) {
                criticalEdges.add(augmentedEdges.get(i)[3]);
                isCritical[augmentedEdges.get(i)[3]] = true;
            }
        }

        for (int i = 0; i < augmentedEdges.size(); i++) {
            int originalIndex = augmentedEdges.get(i)[3];
            if (!isCritical[originalIndex]) {
                int mstWeightWithCurrentForced = kruskal(n, augmentedEdges, -1, i);
                if (mstWeightWithCurrentForced == originalMstWeight) {
                    pseudoCriticalEdges.add(originalIndex);
                }
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        result.add(criticalEdges);
        result.add(pseudoCriticalEdges);
        return result;
    }
}