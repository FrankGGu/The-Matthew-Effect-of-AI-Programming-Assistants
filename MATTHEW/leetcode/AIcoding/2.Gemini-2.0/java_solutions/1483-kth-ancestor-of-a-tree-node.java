class TreeAncestor {

    int[][] dp;
    int maxBit;

    public TreeAncestor(int n, int[] parent) {
        maxBit = (int) (Math.log(n) / Math.log(2)) + 1;
        dp = new int[n][maxBit];

        for (int i = 0; i < n; i++) {
            dp[i][0] = parent[i];
        }

        for (int j = 1; j < maxBit; j++) {
            for (int i = 0; i < n; i++) {
                int ancestor = dp[i][j - 1];
                if (ancestor == -1) {
                    dp[i][j] = -1;
                } else {
                    dp[i][j] = dp[ancestor][j - 1];
                }
            }
        }
    }

    public int getKthAncestor(int node, int k) {
        for (int i = 0; i < maxBit; i++) {
            if ((k & (1 << i)) != 0) {
                node = dp[node][i];
                if (node == -1) {
                    return -1;
                }
            }
        }
        return node;
    }
}