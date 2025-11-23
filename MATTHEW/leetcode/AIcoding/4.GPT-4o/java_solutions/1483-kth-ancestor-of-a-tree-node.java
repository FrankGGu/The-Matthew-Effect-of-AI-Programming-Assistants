class TreeAncestor {
    private int[][] parent;
    private int maxDepth;

    public TreeAncestor(int n, int[] parent) {
        this.maxDepth = (int) (Math.log(n) / Math.log(2)) + 1;
        this.parent = new int[n][maxDepth];
        for (int i = 0; i < n; i++) {
            this.parent[i][0] = parent[i];
        }
        for (int j = 1; j < maxDepth; j++) {
            for (int i = 0; i < n; i++) {
                if (this.parent[i][j - 1] != -1) {
                    this.parent[i][j] = this.parent[this.parent[i][j - 1]][j - 1];
                } else {
                    this.parent[i][j] = -1;
                }
            }
        }
    }

    public int getKthAncestor(int node, int k) {
        for (int j = 0; j < maxDepth; j++) {
            if ((k & (1 << j)) > 0) {
                node = parent[node][j];
                if (node == -1) {
                    return -1;
                }
            }
        }
        return node;
    }
}