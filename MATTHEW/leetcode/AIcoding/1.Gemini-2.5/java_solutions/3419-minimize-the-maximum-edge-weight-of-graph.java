import java.util.Arrays;

class DSU {
    int[] parent;
    int count;

    public DSU(int n) {
        parent = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            parent[i] = i;
        }
        count = n;
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
            parent[rootI] = rootJ;
            count--;
            return true;
        }
        return false;
    }

    public int getCount() {
        return count;
    }
}

class Solution {
    public int minimizeTheMaximumEdgeWeight(int n, int[][] edges) {
        Arrays.sort(edges, (a, b) -> a[2] - b[2]);

        DSU dsu = new DSU(n);

        int maxWeight = 0;
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];

            if (dsu.union(u, v)) {
                maxWeight = Math.max(maxWeight, w);
                if (dsu.getCount() == 1) {
                    return maxWeight;
                }
            }
        }

        return maxWeight;
    }
}