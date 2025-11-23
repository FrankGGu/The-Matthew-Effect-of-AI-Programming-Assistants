#include <stdlib.h>
#include <stdio.h>
#include <math.h> // For fmax

long long collectingChocolates(int* nums, int n, int x) {
    long long max_overall_points = 0;

    // min_values_at_pos[j] stores the minimum value encountered at index j
    // across all rotations considered so far (from 0 up to current k rotations).
    long long* min_values_at_pos = (long long*)malloc(n * sizeof(long long));
    if (min_values_at_pos == NULL) {
        // Handle allocation error
        return 0; 
    }

    long long current_sum_of_min_values = 0;

    // Initialize for k = 0 rotations
    // No rotations, so min_values_at_pos are just the original nums values.
    for (int j = 0; j < n; j++) {
        min_values_at_pos[j] = nums[j];
        current_sum_of_min_values += nums[j];
    }

    // For 0 rotations, cost is 0. The total points are just the sum of initial min_values.
    max_overall_points = current_sum_of_min_values;

    // Iterate through possible number of rotations (k from 1 to n-1)
    for (int k = 1; k < n; k++) {
        long long rotation_cost = (long long)k * x;

        // Update min_values_at_pos for this k-th rotation.
        // For each position `j` in the current array, the element that lands there
        // after `k` rotations originally came from index `(j - k + n) % n`.
        // We update `min_values_at_pos[j]` if this new element is smaller.
        for (int j = 0; j < n; j++) {
            int original_idx_at_j = (j - k + n) % n;
            if (nums[original_idx_at_j] < min_values_at_pos[j]) {
                current_sum_of_min_values -= min_values_at_pos[j]; // Subtract old min value
                min_values_at_pos[j] = nums[original_idx_at_j];    // Update to new min value
                current_sum_of_min_values += min_values_at_pos[j]; // Add new min value
            }
        }

        // Calculate total points for this number of rotations (k)
        // Total points = (sum of current minimum values) - (cost of k rotations)
        max_overall_points = fmax(max_overall_points, current_sum_of_min_values - rotation_cost);
    }

    free(min_values_at_pos);
    return max_overall_points;
}