#include <stdlib.h>

int waysToMakeFair(int* nums, int numsSize) {
    long long even_prefix_sums[numsSize + 1];
    long long odd_prefix_sums[numsSize + 1];

    even_prefix_sums[0] = 0;
    odd_prefix_sums[0] = 0;

    for (int k = 0; k < numsSize; k++) {
        even_prefix_sums[k + 1] = even_prefix_sums[k];
        odd_prefix_sums[k + 1] = odd_prefix_sums[k];
        if (k % 2 == 0) { // k is an even index
            even_prefix_sums[k + 1] += nums[k];
        } else { // k is an odd index
            odd_prefix_sums[k + 1] += nums[k];
        }
    }

    int count = 0;
    long long total_even_sum = even_prefix_sums[numsSize];
    long long total_odd_sum = odd_prefix_sums[numsSize];

    for (int i = 0; i < numsSize; i++) {
        long long current_even_sum_after_deletion;
        long long current_odd_sum_after_deletion;

        // Sum of elements at even indices before 'i' (original indices)
        current_even_sum_after_deletion = even_prefix_sums[i];
        // Sum of elements at odd indices before 'i' (original indices)
        current_odd_sum_after_deletion = odd_prefix_sums[i];

        // Sum of original odd-indexed elements after 'i' that become even-indexed
        current_even_sum_after_deletion += (total_odd_sum - odd_prefix_sums[i + 1]);
        // Sum of original even-indexed elements after 'i' that become odd-indexed
        current_odd_sum_after_deletion += (total_even_sum - even_prefix_sums[i + 1]);

        if (current_even_sum_after_deletion == current_odd_sum_after_deletion) {
            count++;
        }
    }

    return count;
}