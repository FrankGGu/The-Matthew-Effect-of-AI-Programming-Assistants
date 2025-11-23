#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minimalSum(int* nums, int numsSize, int k) {
    long long total_sum = 0;
    long long current_num = 1; // The smallest positive integer we are looking to append

    // Sort nums to easily find missing numbers and handle duplicates efficiently
    qsort(nums, numsSize, sizeof(int), compare);

    for (int i = 0; i < numsSize; ++i) {
        // If nums[i] is greater than current_num, it means there's a gap
        // where we can append numbers (from current_num up to nums[i]-1).
        if (nums[i] > current_num) {
            // Calculate how many numbers are available in this gap.
            long long gap_count = (long long)nums[i] - current_num;

            // We can only add up to 'k' numbers in this gap.
            long long count_to_add = (gap_count < k) ? gap_count : k;

            if (count_to_add > 0) {
                // Calculate the sum of these 'count_to_add' numbers.
                // The sum of an arithmetic series from 'first_val' to 'last_val' is
                // (last_val * (last_val + 1) / 2) - ((first_val - 1) * first_val / 2).
                long long first_val = current_num;
                long long last_val = current_num + count_to_add - 1;
                total_sum += (last_val * (last_val + 1) / 2) - ((first_val - 1) * first_val / 2);
                k -= count_to_add;
            }
        }

        // If k becomes 0, we have appended all required numbers, so we can stop.
        if (k == 0) {
            break;
        }

        // Advance current_num past the current nums[i].
        // This ensures we look for numbers strictly greater than nums[i] in the next iteration.
        // This also handles cases where nums[i] is equal to current_num (already present)
        // or if nums[i] was smaller than current_num (e.g., a duplicate that was skipped).
        if (current_num <= nums[i]) {
            current_num = (long long)nums[i] + 1;
        }
    }

    // After iterating through all numbers in nums, if k is still greater than 0,
    // we need to append the remaining k numbers starting from current_num.
    if (k > 0) {
        long long first_val = current_num;
        long long last_val = current_num + k - 1;
        total_sum += (last_val * (last_val + 1) / 2) - ((first_val - 1) * first_val / 2);
    }

    return total_sum;
}