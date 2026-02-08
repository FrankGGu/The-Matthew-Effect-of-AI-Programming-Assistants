class TreeAncestor {
    private static final int MAX_LOG = 16; // ceil(log2(50000)) = 16
    private int[][] dp; // dp[k][node] stores the 2^k-th ancestor of node

    public TreeAncestor(int n, int[] parent) {
        dp = new int[MAX_LOG][n];

        for (int i = 0; i < n; i++) {
            dp[0][i] = parent[i];
        }

        for (int k = 1; k < MAX_LOG; k++) {
            for (int i = 0; i < n; i++) {
                if (dp[k - 1][i] != -1) {
                    dp[k][i] = dp[k - 1][dp[k - 1][i]];
                } else {
                    dp[k][i] = -1;
                }
            }
        }
    }

    public int getKthAncestor(int node, int k) {
        for (int j = MAX_LOG - 1; j >= 0; j--) {
            if (((k >> j) & 1) == 1) {
                if (node == -1) {
                    return -1;
                }
                node = dp[j][node];
            }
        }
        return node;
    }
}