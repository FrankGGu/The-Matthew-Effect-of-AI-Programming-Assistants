class Solution {
    public int profitableSchemes(int G, int P, int[] group, int[] profit) {
        int mod = 1000000007;
        int n = group.length;
        int[][] dp = new int[P + 1][G + 1];
        dp[0][0] = 1;

        for (int i = 0; i < n; i++) {
            int g = group[i], p = profit[i];
            for (int j = P; j >= 0; j--) {
                for (int k = G - g; k >= 0; k--) {
                    dp[Math.min(P, j + p)][k + g] = (dp[Math.min(P, j + p)][k + g] + dp[j][k]) % mod;
                }
            }
        }

        int result = 0;
        for (int j = 0; j <= G; j++) {
            result = (result + dp[P][j]) % mod;
        }
        return result;
    }
}