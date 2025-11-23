#include <limits.h> // For LLONG_MIN, LLONG_MAX
#include <stdlib.h> // For malloc, free

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

long long maxSumDivisibleByK(int* nums, int numsSize, int k) {
    long long max_sum = LLONG_MIN;
    long long current_prefix_sum = 0;

    // min_prefix_sum_at_rem[r] stores the minimum prefix sum encountered so far
    // whose remainder when divided by k is r.
    // Initialize with LLONG_MAX to indicate no such prefix sum has been found yet.
    long long* min_prefix_sum_at_rem = (long long*)malloc(k * sizeof(long long));
    // In competitive programming, malloc failure is often ignored due to memory limits being generous.
    // For robust code, one might add error handling.
    if (min_prefix_sum_at_rem == NULL) {
        // This case should ideally not happen on LeetCode for typical constraints.
        // Returning 0 or an error code would be appropriate in a production environment.
        // For LeetCode, we assume malloc succeeds.
        return 0; 
    }

    for (int i = 0; i < k; ++i) {
        min_prefix_sum_at_rem[i] = LLONG_MAX;
    }

    // prefixSum[0] is 0 (sum of an empty prefix), and 0 % k = 0.
    // So, initialize for remainder 0 with prefixSum[0].
    min_prefix_sum_at_rem[0] = 0;

    // Iterate through conceptual prefix sums from prefixSum[0] to prefixSum[numsSize].
    // `p` represents the index of the current prefix sum.
    // `current_prefix_sum` stores prefixSum[p].
    // `nums[p-1]` is the element being added to get prefixSum[p] (for p > 0).
    for (int p = 0; p <= numsSize; ++p) {
        if (p > 0) {
            current_prefix_sum += nums[p-1];
        }

        // Calculate the remainder of the current_prefix_sum when divided by k.
        // The `(X % k + k) % k` pattern handles potential negative results from the % operator in C.
        int current_rem = (current_prefix_sum % k + k) % k;

        // If a previous prefix sum `prefixSum[i]` with the same remainder `current_rem` exists (i.e., not LLONG_MAX),
        // we can form a subarray sum `current_prefix_sum - prefixSum[i]`.
        // The length of this subarray is `p - i`.
        // Since `prefixSum[p] % k == prefixSum[i] % k`, it implies `(prefixSum[p] - prefixSum[i]) % k == 0`.
        // This also means `(p - i) % k == 0`.
        // The `min_prefix_sum_at_rem[current_rem]` stores `prefixSum[x]` where `x < p`.
        // Thus, `p - x >= 1`. Since `p - x` must be a multiple of `k`, it implies `p - x >= k`.
        // This ensures the subarray is non-empty and has length at least `k`.
        // The only exception is when `p=0`, `current_prefix_sum=0`, `min_prefix_sum_at_rem[0]=0`.
        // This would calculate `0-0=0`, corresponding to an empty subarray.
        // To strictly adhere to non-empty subarrays, we skip this specific case with `p > 0`.
        if (min_prefix_sum_at_rem[current_rem] != LLONG_MAX) {
            if (p > 0) { // Ensures we are considering a non-empty prefix (p >= 1)
                max_sum = MAX(max_sum, current_prefix_sum - min_prefix_sum_at_rem[current_rem]);
            }
        }

        // Update the minimum prefix sum for the current remainder `current_rem`.
        min_prefix_sum_at_rem[current_rem] = MIN(min_prefix_sum_at_rem[current_rem], current_prefix_sum);
    }

    free(min_prefix_sum_at_rem);

    return max_sum;
}