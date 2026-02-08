class Solution {
    public int removeStones(int[][] stones) {
        int n = stones.length;
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        int components = n;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (stones[i][0] == stones[j][0] || stones[i][1] == stones[j][1]) {
                    if (find(parent, i) != find(parent, j)) {
                        union(parent, i, j);
                        components--;
                    }
                }
            }
        }

        return n - components;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private void union(int[] parent, int i, int j) {
        int rootI = find(parent, i);
        int rootJ = find(parent, j);
        parent[rootI] = rootJ;
    }
}