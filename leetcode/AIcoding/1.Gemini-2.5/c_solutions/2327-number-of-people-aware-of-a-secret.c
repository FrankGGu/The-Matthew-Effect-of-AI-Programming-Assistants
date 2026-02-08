#include <stdlib.h>
#include <string.h>

int peopleAwareOfSecret(int n, int delay, int forget) {
    long long dp[n + 1];
    // Initialize dp array to 0. dp[i] will store the number of people who learn the secret on day i.
    memset(dp, 0, sizeof(dp));

    long long MOD = 1000000007;

    // On day 1, one person learns the secret.
    dp[1] = 1;

    // current_sharers_sum represents the number of people who are able to share the secret
    // on the current day 'i'.
    // This sum is maintained using a sliding window approach.
    long long current_sharers_sum = 0;

    // Iterate from day 1 to day n to calculate dp values for each day.
    // dp[1] is already set, so the loop effectively calculates dp[i] for i from 2 to n.
    for (int i = 1; i <= n; ++i) {
        // People who learned on day (i - delay) become able to share on day i.
        // Add dp[i - delay] to current_sharers_sum if the day is valid.
        if (i - delay >= 1) {
            current_sharers_sum = (current_sharers_sum + dp[i - delay]) % MOD;
        }

        // People who learned on day (i - forget) forget the secret on day i.
        // Subtract dp[i - forget] from current_sharers_sum if the day is valid.
        // We add MOD before taking modulo to handle negative results from subtraction.
        if (i - forget >= 1) {
            current_sharers_sum = (current_sharers_sum - dp[i - forget] + MOD) % MOD;
        }

        // For days after the first (i > 1), the number of new people who learn the secret
        // on day i is equal to the number of people currently able to share.
        // dp[1] is already initialized, so we only update dp[i] for i > 1.
        if (i > 1) {
            dp[i] = current_sharers_sum;
        }
    }

    // Calculate the total number of people aware of the secret on day n.
    // These are people who learned on day j (1 <= j <= n) and have not forgotten by day n.
    // A person who learned on day j forgets on day j + forget.
    // So, they are aware on day n if j + forget > n, which means j > n - forget.
    // The sum is dp[n - forget + 1] + ... + dp[n].
    long long total_aware_on_day_n = 0;
    for (int i = n - forget + 1; i <= n; ++i) {
        if (i >= 1) { // Ensure the day index is valid (e.g., if n - forget + 1 is less than 1)
            total_aware_on_day_n = (total_aware_on_day_n + dp[i]) % MOD;
        }
    }

    return (int)total_aware_on_day_n;
}