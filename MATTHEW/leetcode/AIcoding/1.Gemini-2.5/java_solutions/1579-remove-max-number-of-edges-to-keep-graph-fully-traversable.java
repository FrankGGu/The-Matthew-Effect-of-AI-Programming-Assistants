import java.util.Arrays;

class Solution {

    class UnionFind {
        int[] parent;
        int[] size;
        int components;

        public UnionFind(int n) {
            parent = new int[n + 1];
            size = new int[n + 1];
            for (int i = 0; i <= n; i++) {
                parent[i] = i;
                size[i] = 1;
            }
            components = n;
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
                if (size[rootI] < size[rootJ]) {
                    int temp = rootI;
                    rootI = rootJ;
                    rootJ = temp;
                }
                parent[rootJ] = rootI;
                size[rootI] += size[rootJ];
                components--;
                return true;
            }
            return false;
        }
    }

    public int maxNumEdgesToRemove(int n, int[][] edges) {
        Arrays.sort(edges, (a, b) -> b[0] - a[0]);

        UnionFind ufAlice = new UnionFind(n);
        UnionFind ufBob = new UnionFind(n);

        int edgesUsed = 0;

        for (int[] edge : edges) {
            int type = edge[0];
            int u = edge[1];
            int v = edge[2];

            if (type == 3) {
                boolean mergedForAlice = ufAlice.union(u, v);
                boolean mergedForBob = ufBob.union(u, v);

                if (mergedForAlice || mergedForBob) {
                    edgesUsed++;
                }
            } else if (type == 1) {
                if (ufAlice.union(u, v)) {
                    edgesUsed++;
                }
            } else { // type == 2
                if (ufBob.union(u, v)) {
                    edgesUsed++;
                }
            }
        }

        if (ufAlice.components != 1 || ufBob.components != 1) {
            return -1;
        }

        return edges.length - edgesUsed;
    }
}