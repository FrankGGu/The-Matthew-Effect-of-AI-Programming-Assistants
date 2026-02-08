class Solution {
    public int minScore(int n, int[][] roads) {
        UnionFind uf = new UnionFind(n + 1);
        for (int[] road : roads) {
            uf.union(road[0], road[1]);
        }

        int minScore = Integer.MAX_VALUE;
        for (int[] road : roads) {
            if (uf.find(1) == uf.find(road[0])) {
                minScore = Math.min(minScore, road[2]);
            }
        }
        return minScore;
    }

    class UnionFind {
        private int[] parent;

        public UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
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