import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    class UnionFind {
        int[] parent;
        int[] targetCount; 

        public UnionFind(int n, int[] target) {
            parent = new int[n];
            targetCount = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
                targetCount[i] = target[i];
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
                parent[rootJ] = rootI;
                targetCount[rootI] += targetCount[rootJ];
            }
        }
    }

    public int maximizeTheNumberOfTargetNodes(int n, int[][] edges, int[] target) {
        UnionFind uf = new UnionFind(n, target);

        for (int[] edge : edges) {
            uf.union(edge[0], edge[1]);
        }

        List<Integer> componentTargetCounts = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (uf.parent[i] == i) {
                componentTargetCounts.add(uf.targetCount[i]);
            }
        }

        Collections.sort(componentTargetCounts, Collections.reverseOrder());

        if (componentTargetCounts.isEmpty()) {
            return 0;
        }

        if (componentTargetCounts.size() == 1) {
            return componentTargetCounts.get(0);
        }

        return componentTargetCounts.get(0) + componentTargetCounts.get(1);
    }
}