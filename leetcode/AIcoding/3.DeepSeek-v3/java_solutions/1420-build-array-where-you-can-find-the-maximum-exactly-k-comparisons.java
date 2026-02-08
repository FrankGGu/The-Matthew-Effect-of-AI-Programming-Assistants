class Solution {
    private static final int MOD = 1_000_000_007;

    public int numOfArrays(int n, int m, int k) {
        if (k == 0 || k > m) return 0;
        long[][][] dp = new long[n + 1][m + 1][k + 1];
        for (int max = 1; max <= m; max++) {
            dp[1][max][1] = 1;
        }
        for (int len = 2; len <= n; len++) {
            for (int max = 1; max <= m; max++) {
                for (int cost = 1; cost <= k; cost++) {
                    long sum = 0;
                    sum = (sum + dp[len - 1][max][cost] * max) % MOD;
                    for (int prevMax = 1; prevMax < max; prevMax++) {
                        sum = (sum + dp[len - 1][prevMax][cost - 1]) % MOD;
                    }
                    dp[len][max][cost] = sum;
                }
            }
        }
        long result = 0;
        for (int max = 1; max <= m; max++) {
            result = (result + dp[n][max][k]) % MOD;
        }
        return (int) result;
    }
}