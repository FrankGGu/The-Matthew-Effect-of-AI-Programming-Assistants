class Solution {
    private static final int MOD = 1000000007;

    public int countRoutes(int[] locations, int start, int finish, int fuel) {
        int n = locations.length;
        int[][] dp = new int[n][fuel + 1];

        for (int i = 0; i <= fuel; i++) {
            dp[finish][i] = 1;
        }

        for (int j = 0; j <= fuel; j++) {
            for (int i = 0; i < n; i++) {
                for (int k = 0; k < n; k++) {
                    if (i != k) {
                        int cost = Math.abs(locations[i] - locations[k]);
                        if (cost <= j) {
                            dp[i][j] = (dp[i][j] + dp[k][j - cost]) % MOD;
                        }
                    }
                }
            }
        }

        return dp[start][fuel];
    }
}