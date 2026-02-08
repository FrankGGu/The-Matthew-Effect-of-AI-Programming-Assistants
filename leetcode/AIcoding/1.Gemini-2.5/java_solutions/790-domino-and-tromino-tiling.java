class Solution {
    public int numTilings(int n) {
        if (n == 1) {
            return 1;
        }
        if (n == 2) {
            return 5;
        }

        long[] dp = new long[n + 1];
        int MOD = 1_000_000_007;

        // Base cases for the recurrence relation
        // dp[0] represents the number of ways to tile an empty board, which is 1.
        // This is crucial for the recurrence dp[i] = 2 * dp[i-1] + dp[i-3]
        // where dp[i-3] can eventually refer to dp[0].
        dp[0] = 1; 
        dp[1] = 1;
        dp[2] = 5;

        for (int i = 3; i <= n; i++) {
            // The recurrence relation for this problem is derived from
            // dp[i] = dp[i-1] + dp[i-2] + 2 * (dp[i-3] + dp[i-4] + ... + dp[0])
            // and dp[i-1] = dp[i-2] + dp[i-3] + 2 * (dp[i-4] + ... + dp[0])
            // Subtracting the second from the first gives:
            // dp[i] - dp[i-1] = dp[i-1] + dp[i-3]
            // dp[i] = 2 * dp[i-1] + dp[i-3]
            // All calculations are performed modulo 10^9 + 7 to prevent overflow.
            // Using long for dp array elements to prevent overflow before taking modulo.
            dp[i] = (2 * dp[i-1] + dp[i-3]) % MOD;
        }

        return (int) dp[n];
    }
}