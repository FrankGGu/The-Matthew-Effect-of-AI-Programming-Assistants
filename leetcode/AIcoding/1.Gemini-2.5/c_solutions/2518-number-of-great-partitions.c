#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

int greatPartitions(int* nums, int numsSize, int k) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    // If total sum is less than 2k, it's impossible to have two non-empty partitions each >= k
    if (totalSum < 2LL * k) {
        return 0;
    }

    // dp[s] will store the number of ways to form a subsequence with sum s.
    // We need to count subsets with sum strictly less than k.
    // So, we need to compute dp values up to k-1.
    // However, k can be up to 10^9, which is too large for a direct array.
    // The common approach for such problems with N <= 1000 is to cap the DP array size.
    // Let's use `MAX_DP_ARRAY_SIZE` as the cap.
    // The DP array will store counts for sums from 0 up to `dp_max_val - 1`.
    // If `k` is larger than `MAX_DP_ARRAY_SIZE`, we only compute sums up to `MAX_DP_ARRAY_SIZE - 1`.
    // This is because if `k` is very large, any sum `s` that is less than `MAX_DP_ARRAY_SIZE` will also be less than `k`.

    const int MAX_DP_ARRAY_SIZE = 200005; // A common upper bound for k in N=1000 problems
    long long dp_max_val = (long long)k; // We need sums < k, so array size k.
                                          // Values in dp array are for sums 0 to k-1.

    if (dp_max_val > MAX_DP_ARRAY_SIZE) {
        dp_max_val = MAX_DP_ARRAY_SIZE;
    }

    long long* dp = (long long*)calloc(dp_max_val, sizeof(long long));
    if (dp == NULL) {
        return 0; 
    }

    dp[0] = 1; // One way to get sum 0 (empty set)

    for (int i = 0; i < numsSize; i++) {
        for (long long s = dp_max_val - 1; s >= nums[i]; s--) {
            dp[s] = (dp[s] + dp[s - nums[i]]) % MOD;
        }
    }

    long long count_subsets_sum_lt_k = 0;
    // Sum up all dp values for sums s < k (or s < dp_max_val if k is capped)
    for (long long s = 0; s < dp_max_val; s++) {
        count_subsets_sum_lt_k = (count_subsets_sum_lt_k + dp[s]) % MOD;
    }

    free(dp);

    // Total possible ways to partition into two subsequences (including empty ones) is 2^numsSize.
    long long total_subsets_all = power(2, numsSize);

    // Number of "bad" partitions: where sum(sub1) < k OR sum(sub2) < k.
    // Since totalSum >= 2k, it's impossible for both sum(sub1) < k AND sum(sub2) < k to be true simultaneously.
    // So, N_bad = (count of subsets A with sum(A) < k) + (count of subsets A with sum(A) > totalSum - k).
    // The second term (subsets with sum > totalSum - k) is equivalent to (subsets B whose complement has sum < k).
    // So, N_bad = 2 * (count of subsets with sum < k).
    // `count_subsets_sum_lt_k` already includes the empty set (sum 0).
    // The two "invalid" partitions (empty, nums) and (nums, empty) are correctly classified as "bad" by this logic:
    // - (empty, nums): sum(empty) = 0 < k. This is counted in `count_subsets_sum_lt_k`.
    // - (nums, empty): sum(empty) = 0 < k. This is also implicitly covered when we multiply by 2.
    // So, `2 * count_subsets_sum_lt_k` correctly represents all partitions where at least one subsequence sum is less than k,
    // including the two partitions with an empty subsequence.
    long long bad_partitions_count = (2 * count_subsets_sum_lt_k) % MOD;

    long long result = (total_subsets_all - bad_partitions_count + MOD) % MOD;

    return (int)result;
}