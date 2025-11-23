class Solution {
    public List<List<Integer>> findCriticalAndPseudoCriticalEdges(int n, int[][] edges) {
        int m = edges.length;
        int[][] newEdges = new int[m][4];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < 3; j++) {
                newEdges[i][j] = edges[i][j];
            }
            newEdges[i][3] = i;
        }
        Arrays.sort(newEdges, (a, b) -> Integer.compare(a[2], b[2]));
        UnionFind ufStd = new UnionFind(n);
        int stdWeight = 0;
        for (int[] edge : newEdges) {
            if (ufStd.union(edge[0], edge[1])) {
                stdWeight += edge[2];
            }
        }
        List<List<Integer>> result = new ArrayList<>();
        result.add(new ArrayList<>());
        result.add(new ArrayList<>());
        for (int i = 0; i < m; i++) {
            UnionFind ufIgnore = new UnionFind(n);
            int ignoreWeight = 0;
            for (int j = 0; j < m; j++) {
                if (i != j && ufIgnore.union(newEdges[j][0], newEdges[j][1])) {
                    ignoreWeight += newEdges[j][2];
                }
            }
            if (ufIgnore.count != 1 || ignoreWeight > stdWeight) {
                result.get(0).add(newEdges[i][3]);
                continue;
            }
            UnionFind ufForce = new UnionFind(n);
            int forceWeight = newEdges[i][2];
            ufForce.union(newEdges[i][0], newEdges[i][1]);
            for (int j = 0; j < m; j++) {
                if (i != j && ufForce.union(newEdges[j][0], newEdges[j][1])) {
                    forceWeight += newEdges[j][2];
                }
            }
            if (forceWeight == stdWeight) {
                result.get(1).add(newEdges[i][3]);
            }
        }
        return result;
    }

    class UnionFind {
        int[] parent;
        int[] rank;
        int count;

        public UnionFind(int n) {
            parent = new int[n];
            rank = new int[n];
            count = n;
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

        public boolean union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) {
                return false;
            }
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
    }
}