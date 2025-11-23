#include <stdlib.h>
#include <limits.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long stoneGameVIII(int* stones, int stonesSize) {
    if (stonesSize == 1) {
        return (long long)stones[0];
    }

    long long* prefix_sum = (long long*)malloc((stonesSize + 1) * sizeof(long long));
    prefix_sum[0] = 0;
    for (int i = 0; i < stonesSize; ++i) {
        prefix_sum[i + 1] = prefix_sum[i] + stones[i];
    }

    long long* dp = (long long*)malloc(stonesSize * sizeof(long long));

    dp[0] = (long long)stones[0];

    long long max_dp_so_far = dp[0];
    long long max_dp_plus_prefix_so_far = dp[0] + prefix_sum[1];

    long long overall_max_score = dp[0];

    for (int j = 1; j < stonesSize; ++j) {
        long long current_dp_j = (long long)stones[j] + max(max_dp_so_far, max_dp_plus_prefix_so_far - prefix_sum[j]);
        dp[j] = current_dp_j;

        overall_max_score = max(overall_max_score, dp[j]);

        max_dp_so_far = max(max_dp_so_far, dp[j]);
        max_dp_plus_prefix_so_far = max(max_dp_plus_prefix_so_far, dp[j] + prefix_sum[j + 1]);
    }

    free(prefix_sum);
    free(dp);

    return overall_max_score;
}