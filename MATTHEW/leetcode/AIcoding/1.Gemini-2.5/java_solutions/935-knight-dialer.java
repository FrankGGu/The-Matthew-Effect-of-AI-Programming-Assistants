class Solution {
    public int knightDialer(int n) {
        if (n == 1) {
            return 10;
        }

        long MOD = 1_000_000_007;

        int[][] jumps = {
            {4, 6},    // 0
            {6, 8},    // 1
            {7, 9},    // 2
            {4, 8},    // 3
            {0, 3, 9}, // 4
            {},        // 5
            {0, 1, 7}, // 6
            {2, 6},    // 7
            {1, 3},    // 8
            {2, 4}     // 9
        };

        long[] dp = new long[10];
        for (int i = 0; i < 10; i++) {
            dp[i] = 1;
        }

        for (int len = 2; len <= n; len++) {
            long[] next_dp = new long[10];
            for (int digit = 0; digit < 10; digit++) {
                if (dp[digit] == 0) {
                    continue; 
                }
                for (int nextDigit : jumps[digit]) {
                    next_dp[nextDigit] = (next_dp[nextDigit] + dp[digit]) % MOD;
                }
            }
            dp = next_dp;
        }

        long totalCount = 0;
        for (long count : dp) {
            totalCount = (totalCount + count) % MOD;
        }

        return (int) totalCount;
    }
}