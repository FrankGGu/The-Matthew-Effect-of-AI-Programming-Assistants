class TreeAncestor {
    private int[][] up;
    private int maxPow;

    public TreeAncestor(int n, int[] parent) {
        maxPow = (int) (Math.log(n) / Math.log(2)) + 1;
        up = new int[n][maxPow];
        for (int i = 0; i < n; i++) {
            up[i][0] = parent[i];
        }
        for (int j = 1; j < maxPow; j++) {
            for (int i = 0; i < n; i++) {
                if (up[i][j - 1] == -1) {
                    up[i][j] = -1;
                } else {
                    up[i][j] = up[up[i][j - 1]][j - 1];
                }
            }
        }
    }

    public int getKthAncestor(int node, int k) {
        for (int i = 0; i < maxPow; i++) {
            if (((k >> i) & 1) == 1) {
                node = up[node][i];
                if (node == -1) return -1;
            }
        }
        return node;
    }
}