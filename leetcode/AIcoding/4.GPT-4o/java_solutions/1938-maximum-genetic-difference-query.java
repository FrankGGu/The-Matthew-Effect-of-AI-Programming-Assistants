class Solution {
    public int[] maxGeneticDifference(int[] parents, int[][] queries) {
        int n = parents.length;
        int m = queries.length;
        int[] result = new int[m];

        int[][] dp = new int[n][32];
        for (int i = 0; i < n; i++) {
            if (parents[i] != -1) {
                dp[i] = dp[parents[i]].clone();
            }
            dp[i][0] |= (1 << i);
        }

        for (int j = 1; j < 32; j++) {
            for (int i = 0; i < n; i++) {
                dp[i][j] = dp[i][j - 1] | dp[parents[i]][j - 1];
            }
        }

        for (int q = 0; q < m; q++) {
            int x = queries[q][0];
            int y = queries[q][1];
            int maxDiff = 0;
            for (int bit = 0; bit < 32; bit++) {
                if (((dp[x][bit] ^ dp[y][bit]) & (1 << x)) != 0) {
                    maxDiff |= (1 << bit);
                }
            }
            result[q] = maxDiff;
        }

        return result;
    }
}