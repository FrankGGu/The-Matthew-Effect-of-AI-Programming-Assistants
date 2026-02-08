class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int MAX_N = 10_000;
    private static final int MAX_K = 14;
    private static int[][] comb = new int[MAX_N + MAX_K][MAX_K + 1];

    static {
        for (int i = 0; i < comb.length; i++) {
            comb[i][0] = 1;
            if (i <= MAX_K) {
                comb[i][i] = 1;
            }
            for (int j = 1; j < i && j <= MAX_K; j++) {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % MOD;
            }
        }
    }

    public int idealArrays(int n, int maxValue) {
        int[] dp = new int[maxValue + 1];
        Arrays.fill(dp, 1);
        int res = 0;
        for (int len = 1; len <= MAX_K; len++) {
            int[] next = new int[maxValue + 1];
            for (int num = 1; num <= maxValue; num++) {
                for (int multiple = 2 * num; multiple <= maxValue; multiple += num) {
                    next[multiple] = (next[multiple] + dp[num]) % MOD;
                }
            }
            for (int num = 1; num <= maxValue; num++) {
                dp[num] = next[num];
                res = (res + (int) ((long) comb[n - 1][len - 1] * dp[num] % MOD)) % MOD;
            }
        }
        return res;
    }
}