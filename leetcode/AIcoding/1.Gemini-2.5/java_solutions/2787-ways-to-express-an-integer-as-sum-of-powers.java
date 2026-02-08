class Solution {
    public int waysToExpressProducts(int n, int x) {
        int MOD = 1_000_000_007;
        int[] dp = new int[n + 1];
        dp[0] = 1;

        for (int b = 1; ; b++) {
            long power_val_long = 1;
            // Calculate b^x, checking for overflow and if it exceeds n
            for (int k = 0; k < x; k++) {
                // Check if power_val_long * b would exceed n
                // This also implicitly handles potential long overflow if n is large,
                // but n is only 10^5, so power_val_long won't overflow long itself
                // before exceeding n.
                if (power_val_long > n / b) { 
                    power_val_long = n + 1; // Mark as too large
                    break;
                }
                power_val_long *= b;
            }

            if (power_val_long > n) {
                break; // b^x is too large, stop iterating bases
            }

            int power_val = (int) power_val_long; // Safe to cast now as it's <= n

            // Update dp array using the current power_val
            // Iterate backwards to ensure each power_val is used at most once (unique bases)
            for (int j = n; j >= power_val; j--) {
                dp[j] = (dp[j] + dp[j - power_val]) % MOD;
            }
        }

        return dp[n];
    }
}