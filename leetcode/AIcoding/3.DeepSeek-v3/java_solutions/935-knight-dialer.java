class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int[][] moves = {
        {4, 6},    // 0
        {6, 8},    // 1
        {7, 9},    // 2
        {4, 8},    // 3
        {3, 9, 0}, // 4
        {},        // 5
        {1, 7, 0},  // 6
        {2, 6},     // 7
        {1, 3},     // 8
        {2, 4}      // 9
    };

    public int knightDialer(int n) {
        if (n == 1) return 10;
        long[] dp = new long[10];
        Arrays.fill(dp, 1);

        for (int step = 2; step <= n; step++) {
            long[] next = new long[10];
            for (int num = 0; num < 10; num++) {
                for (int neighbor : moves[num]) {
                    next[num] = (next[num] + dp[neighbor]) % MOD;
                }
            }
            dp = next;
        }

        long total = 0;
        for (long count : dp) {
            total = (total + count) % MOD;
        }
        return (int) total;
    }
}