#include <limits.h> // For LLONG_MAX, LLONG_MIN

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long maximumValueSum(int* nums, int numsSize, int k, int** edges, int edgesSize, int* edgesColSize) {
    long long initial_sum = 0;
    long long total_gain_from_positives = 0;
    int positive_count = 0;
    long long min_positive_diff = LLONG_MAX; // Stores the smallest positive gain
    long long max_non_positive_diff = LLONG_MIN; // Stores the largest non-positive gain (0 or negative)

    for (int i = 0; i < numsSize; ++i) {
        long long current_val = nums[i];
        long long flipped_val = nums[i] ^ k;
        long long gain = flipped_val - current_val;

        initial_sum += current_val;

        if (gain > 0) {
            total_gain_from_positives += gain;
            positive_count++;
            min_positive_diff = min(min_positive_diff, gain);
        } else {
            max_non_positive_diff = max(max_non_positive_diff, gain);
        }
    }

    long long final_sum = initial_sum + total_gain_from_positives;

    // If the count of nodes with positive gain is odd, we need to adjust.
    // This is because operations on edges always flip two nodes,
    // meaning the total number of flipped nodes must be even.
    // If we have an odd number of positive-gain flips, we must make one more change
    // to make the total number of flips even.
    // We have two options for this extra change:
    // 1. Un-flip one node that had a positive gain: This reduces the sum by `min_positive_diff`.
    // 2. Flip one node that had a non-positive gain: This changes the sum by `max_non_positive_diff` (which is 0 or negative).
    // We choose the option that results in the smallest reduction (or largest increase).
    if (positive_count % 2 == 1) {
        final_sum += max(max_non_positive_diff, -min_positive_diff);
    }

    return final_sum;
}