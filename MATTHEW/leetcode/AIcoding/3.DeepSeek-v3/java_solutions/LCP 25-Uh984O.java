class Solution {
    public int keyboard(int k, int n) {
        int MOD = 1000000007;
        long[][] dp = new long[n + 1][27];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= 26; j++) {
                for (int l = 0; l <= Math.min(k, i); l++) {
                    if (dp[i - l][j - 1] == 0) continue;
                    long ways = dp[i - l][j - 1];
                    ways = ways * comb(i, l) % MOD;
                    dp[i][j] = (dp[i][j] + ways) % MOD;
                }
            }
        }

        return (int) dp[n][26];
    }

    private long comb(int n, int k) {
        if (k == 0 || k == n) return 1;
        k = Math.min(k, n - k);
        long res = 1;
        for (int i = 1; i <= k; i++) {
            res = res * (n - k + i) / i;
        }
        return res;
    }
}