#include <stdlib.h>
#include <limits.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maximumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int n = numsSize;
    int m = multipliersSize;

    long long* dp = (long long*)malloc((m + 1) * sizeof(long long));

    for (int i = 0; i <= m; ++i) {
        dp[i] = LLONG_MIN;
    }
    dp[0] = 0;

    for (int k = 1; k <= m; ++k) {
        int current_multiplier = multipliers[k - 1];

        for (int l = k; l >= 0; --l) {
            int r = k - l;

            long long option1 = LLONG_MIN;
            long long option2 = LLONG_MIN;

            if (l > 0 && dp[l - 1] != LLONG_MIN) {
                option1 = dp[l - 1] + (long long)nums[l - 1] * current_multiplier;
            }

            if (r > 0 && dp[l] != LLONG_MIN) {
                option2 = dp[l] + (long long)nums[n - r] * current_multiplier;
            }

            dp[l] = max(option1, option2);
        }
    }

    long long max_score = LLONG_MIN;
    for (int l = 0; l <= m; ++l) {
        max_score = max(max_score, dp[l]);
    }

    free(dp);

    return max_score;
}