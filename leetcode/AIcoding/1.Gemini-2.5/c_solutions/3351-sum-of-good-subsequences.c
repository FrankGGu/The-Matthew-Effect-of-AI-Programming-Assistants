#include <string.h>

#define MOD 1000000007

typedef struct {
    int count;
    int sum;
} State;

int sumOfGoodSubsequences(char* s) {
    State dp[3];
    State next_dp[3];

    dp[0].count = 1;
    dp[0].sum = 0;
    dp[1].count = 0;
    dp[1].sum = 0;
    dp[2].count = 0;
    dp[2].sum = 0;

    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        int digit = s[i] - '0';

        next_dp[0].count = 0;
        next_dp[0].sum = 0;
        next_dp[1].count = 0;
        next_dp[1].sum = 0;
        next_dp[2].count = 0;
        next_dp[2].sum = 0;

        for (int rem = 0; rem < 3; rem++) {
            // Case 1: Don't include current digit s[i]
            next_dp[rem].count = (next_dp[rem].count + dp[rem].count) % MOD;
            next_dp[rem].sum = (next_dp[rem].sum + dp[rem].sum) % MOD;

            // Case 2: Include current digit s[i]
            int new_rem = (rem + digit) % 3;
            int new_count = dp[rem].count;

            long long current_sum_val = (long long)dp[rem].sum * 10LL;
            long long current_count_val = (long long)dp[rem].count * digit;
            long long new_sum = (current_sum_val + current_count_val) % MOD;

            next_dp[new_rem].count = (next_dp[new_rem].count + new_count) % MOD;
            next_dp[new_rem].sum = (next_dp[new_rem].sum + (int)new_sum) % MOD;
        }

        dp[0] = next_dp[0];
        dp[1] = next_dp[1];
        dp[2] = next_dp[2];
    }

    return dp[0].sum;
}