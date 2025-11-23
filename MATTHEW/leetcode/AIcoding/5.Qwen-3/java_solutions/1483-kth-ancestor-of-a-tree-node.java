public class Solution {
    public int[] getKthAncestor(int n, int[] parent, int[] queries) {
        int[][] dp = new int[n][];
        for (int i = 0; i < n; i++) {
            dp[i] = new int[20]; // since 2^20 > 1e5
        }

        for (int i = 0; i < n; i++) {
            dp[i][0] = parent[i];
        }

        for (int j = 1; j < 20; j++) {
            for (int i = 0; i < n; i++) {
                if (dp[i][j - 1] != -1) {
                    dp[i][j] = dp[dp[i][j - 1]][j - 1];
                } else {
                    dp[i][j] = -1;
                }
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int node = queries[i];
            int k = queries[i];
            for (int j = 0; j < 20; j++) {
                if ((k & (1 << j)) != 0) {
                    node = dp[node][j];
                    if (node == -1) break;
                }
            }
            result[i] = node;
        }

        return result;
    }
}