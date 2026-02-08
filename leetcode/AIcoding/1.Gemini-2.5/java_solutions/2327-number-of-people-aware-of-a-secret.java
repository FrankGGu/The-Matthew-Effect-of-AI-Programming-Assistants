class Solution {
    public int peopleAwareOfSecret(int n, int delay, int forget) {
        int MOD = 1_000_000_007;

        // dp[i] stores the number of people who learned the secret on day i.
        long[] dp = new long[n + 1];

        // On day 1, one person knows the secret.
        // This person learned the secret on day 1.
        dp[1] = 1;

        // 'spreading' tracks the number of people who are currently capable of spreading the secret.
        // This represents the sum of dp[j] for j in the range (current_day - forget, current_day - delay].
        long spreading = 0;

        for (int i = 2; i <= n; i++) {
            // People who learned on day 'i - forget' forget the secret today.
            // Remove them from the 'spreading' count.
            // This condition ensures we don't access dp[0] or negative indices.
            if (i - forget >= 1) {
                spreading = (spreading - dp[i - forget] + MOD) % MOD;
            }

            // People who learned on day 'i - delay' can now start spreading the secret.
            // Add them to the 'spreading' count.
            // This condition ensures we don't access dp[0] or negative indices.
            if (i - delay >= 1) {
                spreading = (spreading + dp[i - delay]) % MOD;
            }

            // The number of people who learn the secret on day 'i'
            // is equal to the number of people currently spreading it.
            dp[i] = spreading;
        }

        // The total number of people aware of the secret on day 'n'
        // is the sum of people who learned on day 'j' and have not forgotten yet.
        // A person who learned on day j is still aware on day n if j + forget > n,
        // which means j > n - forget.
        // So, we sum dp[j] for j from max(1, n - forget + 1) to n.
        long totalAware = 0;
        for (int j = n - forget + 1; j <= n; j++) {
            if (j >= 1) { // Ensure j is a valid day index
                totalAware = (totalAware + dp[j]) % MOD;
            }
        }

        return (int) totalAware;
    }
}