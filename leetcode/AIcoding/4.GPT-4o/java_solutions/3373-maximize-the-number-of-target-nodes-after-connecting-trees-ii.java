class Solution {
    public int connectTwoGroups(List<List<Integer>> cost) {
        int m = cost.size(), n = cost.get(0).size();
        int[][] dp = new int[m + 1][1 << n];
        for (int i = 1; i <= m; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
            for (int j = 0; j < (1 << n); j++) {
                if (dp[i - 1][j] != Integer.MAX_VALUE) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j]);
                    for (int k = 0; k < n; k++) {
                        if ((j & (1 << k)) == 0) {
                            dp[i][j | (1 << k)] = Math.min(dp[i][j | (1 << k)], dp[i - 1][j] + cost[i - 1].get(k));
                        }
                    }
                }
            }
        }
        int ans = Integer.MAX_VALUE;
        for (int j = 0; j < (1 << n); j++) {
            ans = Math.min(ans, dp[m][j]);
        }
        return ans;
    }
}