class Solution {
    public int distinctSequences(int n) {
        int MOD = 1000000007;
        long[][] dp = new long[n + 1][1 << 6];

        dp[0][0] = 1;

        for (int length = 1; length <= n; length++) {
            for (int mask = 0; mask < (1 << 6); mask++) {
                for (int die = 1; die <= 6; die++) {
                    if ((mask & (1 << (die - 1))) == 0) {
                        int newMask = mask | (1 << (die - 1));
                        int prevDie = 0;
                        for (int prev = 1; prev <= 6; prev++) {
                            if ((mask & (1 << (prev - 1))) != 0) {
                                prevDie++;
                            }
                        }
                        if (prevDie < 2) {
                            dp[length][newMask] = (dp[length][newMask] + dp[length - 1][mask]) % MOD;
                        }
                    }
                }
            }
        }

        long result = 0;
        for (int mask = 0; mask < (1 << 6); mask++) {
            result = (result + dp[n][mask]) % MOD;
        }

        return (int) result;
    }
}