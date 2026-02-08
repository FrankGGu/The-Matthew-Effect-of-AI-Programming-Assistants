class Solution {
    public int[] findRedundantDirectedConnection(int[][] edges) {
        int n = edges.length;
        int[] parent = new int[n + 1];
        int[] indegree = new int[n + 1];
        for (int i = 0; i < n; i++) {
            indegree[edges[i][1]]++;
        }

        int[] edgeToRemove = null;
        for (int[] edge : edges) {
            if (indegree[edge[1]] == 2) {
                edgeToRemove = edge;
                break;
            }
        }

        UnionFind uf = new UnionFind(n);
        for (int[] edge : edges) {
            if (edgeToRemove != null && edge[0] == edgeToRemove[0] && edge[1] == edgeToRemove[1]) {
                continue;
            }
            if (!uf.union(edge[0], edge[1])) {
                return edge;
            }
        }

        return edgeToRemove;
    }

    class UnionFind {
        int[] parent;

        public UnionFind(int n) {
            parent = new int[n + 1];
            for (int i = 1; i <= n; i++) {
                parent[i] = i;
            }
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
            if (rootX == rootY) {
                return false;
            }
            parent[rootX] = rootY;
            return true;
        }
    }
}