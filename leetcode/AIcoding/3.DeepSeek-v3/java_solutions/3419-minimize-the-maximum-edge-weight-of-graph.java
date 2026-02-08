class Solution {
    public int minMaxEdgeWeight(int n, int[][] edges) {
        int left = 0, right = 0;
        for (int[] edge : edges) {
            right = Math.max(right, edge[2]);
        }

        int result = right;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canFormTree(n, edges, mid)) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return result;
    }

    private boolean canFormTree(int n, int[][] edges, int maxWeight) {
        UnionFind uf = new UnionFind(n);
        for (int[] edge : edges) {
            if (edge[2] <= maxWeight) {
                uf.union(edge[0], edge[1]);
            }
        }
        return uf.getCount() == 1;
    }

    class UnionFind {
        private int[] parent;
        private int[] rank;
        private int count;

        public UnionFind(int size) {
            parent = new int[size];
            rank = new int[size];
            count = size;
            for (int i = 0; i < size; i++) {
                parent[i] = i;
                rank[i] = 1;
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
                if (rank[rootX] > rank[rootY]) {
                    parent[rootY] = rootX;
                } else if (rank[rootX] < rank[rootY]) {
                    parent[rootX] = rootY;
                } else {
                    parent[rootY] = rootX;
                    rank[rootX]++;
                }
                count--;
            }
        }

        public int getCount() {
            return count;
        }
    }
}