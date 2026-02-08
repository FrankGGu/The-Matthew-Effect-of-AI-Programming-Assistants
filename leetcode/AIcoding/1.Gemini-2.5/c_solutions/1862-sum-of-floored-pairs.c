#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define MAX_NUM_VAL 100000

int freq[MAX_NUM_VAL + 1];
long long prefix_sum_freq[MAX_NUM_VAL + 1];

long long sumOfFlooredPairs(int* nums, int numsSize) {
    // Clear freq and prefix_sum_freq for the current test case.
    // This is crucial for LeetCode's test system where global variables persist between calls.
    memset(freq, 0, sizeof(freq));
    memset(prefix_sum_freq, 0, sizeof(prefix_sum_freq)); // prefix_sum_freq[0] will be 0

    int max_val = 0;
    // 1. Find the maximum value in nums and populate the frequency array.
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
        freq[nums[i]]++;
    }

    // 2. Populate the prefix sum frequency array.
    // prefix_sum_freq[i] stores the count of numbers in nums that are less than or equal to i.
    for (int i = 1; i <= max_val; i++) {
        prefix_sum_freq[i] = prefix_sum_freq[i - 1] + freq[i];
    }

    long long total_sum = 0;

    // 3. Iterate through all possible values of nums[j] (represented by 'y').
    for (int y = 1; y <= max_val; y++) {
        // If 'y' does not appear in nums, it cannot be nums[j], so it contributes nothing.
        if (freq[y] == 0) {
            continue;
        }

        long long current_y_contribution_from_x = 0; // Sum of floor(x/y) for all x in nums

        // Iterate through possible quotient values 'k' (where k = floor(x/y)).
        // k starts from 1 because floor(x/y) = 0 contributes 0 to the sum.
        // The loop continues as long as k*y is within the range of possible x values (1 to max_val).
        for (int k = 1; ; k++) {
            long long lower_bound_x = (long long)k * y;

            // If the lower bound for x exceeds max_val, there are no more x values
            // for this 'y' that would result in this 'k' or higher.
            if (lower_bound_x > max_val) {
                break;
            }

            long long upper_bound_x = (long long)(k + 1) * y - 1;
            // Ensure the upper bound for x does not exceed max_val.
            long long actual_upper_bound_x = (upper_bound_x > max_val) ? max_val : upper_bound_x;

            // Count how many numbers 'x' in 'nums' fall into the range [lower_bound_x, actual_upper_bound_x].
            // These are the 'x' values for which floor(x/y) will be equal to 'k'.
            long long count_x_in_range = prefix_sum_freq[actual_upper_bound_x] - prefix_sum_freq[lower_bound_x - 1];

            // Add k * (number of x's that yield k as quotient) to the sum for this 'y'.
            current_y_contribution_from_x += (long long)k * count_x_in_range;
        }

        // Multiply by freq[y] because there are freq[y] occurrences of 'y' as nums[j].
        total_sum += current_y_contribution_from_x * freq[y];
    }

    return total_sum;
}