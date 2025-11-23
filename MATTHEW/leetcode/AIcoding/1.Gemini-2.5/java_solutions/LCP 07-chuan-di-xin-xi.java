import java.util.ArrayList;
import java.util.List;

class Solution {
    public int numWays(int n, int[][] relation, int k) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : relation) {
            int src = edge[0];
            int dst = edge[1];
            adj.get(src).add(dst);
        }

        int[][] dp = new int[k + 1][n];

        dp[0][0] = 1;

        for (int s = 0; s < k; s++) {
            for (int u = 0; u < n; u++) {
                if (dp[s][u] > 0) {
                    for (int v : adj.get(u)) {
                        dp[s + 1][v] += dp[s][u];
                    }
                }
            }
        }

        return dp[k][n - 1];
    }
}