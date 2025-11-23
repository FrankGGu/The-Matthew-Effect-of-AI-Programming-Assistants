#include <stdlib.h>
#include <string.h> // Not strictly needed, but useful for other C functions

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minimumTotalCost(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long total_cost = 0;
    int bad_count = 0;

    // Allocate temporary array to store values from bad positions
    // Max size is nums1Size, but only bad_count elements will be used
    int* bad_vals_arr = (int*)malloc(nums1Size * sizeof(int));
    if (!bad_vals_arr) {
        // Handle allocation failure, though LeetCode usually assumes success
        return -1; 
    }
    int bad_vals_idx = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] == nums2[i]) {
            total_cost += nums1[i];
            bad_count++;
            bad_vals_arr[bad_vals_idx++] = nums1[i];
        }
    }

    if (bad_count == 0) {
        free(bad_vals_arr);
        return 0;
    }

    // Sort bad_vals_arr to easily compute frequencies and max_f_val
    qsort(bad_vals_arr, bad_vals_idx, sizeof(int), compareInts);

    int max_f = 0;
    int max_f_val = -1; // Stores the value that has max_f frequency
    int current_f = 0;
    int current_val = -1;

    // Iterate through sorted bad_vals_arr to find the most frequent value
    for (int k = 0; k < bad_vals_idx; k++) {
        if (bad_vals_arr[k] == current_val) {
            current_f++;
        } else {
            if (current_f > max_f) {
                max_f = current_f;
                max_f_val = current_val;
            }
            current_val = bad_vals_arr[k];
            current_f = 1;
        }
    }
    // Check the last group of values after the loop finishes
    if (current_f > max_f) {
        max_f = current_f;
        max_f_val = current_val;
    }

    // If the most frequent bad value does not dominate (i.e., its count is
    // less than or equal to the count of all other bad values combined),
    // we can fix all bad positions by swapping values among themselves.
    // In this scenario, the total cost is simply the sum of values at bad positions.
    if (max_f * 2 <= bad_count) {
        free(bad_vals_arr);
        return total_cost;
    }

    // If max_f_val dominates (i.e., its count is greater than the count of
    // all other bad values combined), we need to perform additional swaps.
    // Specifically, (2 * max_f - bad_count) instances of max_f_val
    // cannot be fixed by swapping with other bad values. These must be
    // swapped with values from "good" positions.
    int needed_swaps_with_good = (2 * max_f - bad_count);

    // Allocate temporary array to store values from good positions that can be used for swaps
    int* good_candidates = (int*)malloc(nums1Size * sizeof(int));
    if (!good_candidates) {
        free(bad_vals_arr);
        return -1; // Allocation failure
    }
    int good_candidates_idx = 0;

    for (int i = 0; i < nums1Size; i++) {
        // Check if position 'i' is a "good" position (nums1[i] != nums2[i])
        if (nums1[i] != nums2[i]) {
            // For a swap between a 'max_f_val' at a bad position and 'nums1[i]' at a good position
            // to be valid and effective:
            // 1. The value at the good position (nums1[i]) must not be max_f_val.
            //    (This ensures the bad position, after receiving nums1[i], becomes truly unequal).
            // 2. The value max_f_val must not be equal to nums2[i].
            //    (This ensures the good position, after receiving max_f_val, does not become bad).
            if (nums1[i] != max_f_val && nums2[i] != max_f_val) {
                good_candidates[good_candidates_idx++] = nums1[i];
            }
        }
    }

    // Sort good_candidates to pick the smallest values, as these contribute
    // additively to the total cost.
    qsort(good_candidates, good_candidates_idx, sizeof(int), compareInts);

    // Add the smallest 'needed_swaps_with_good' values from good_candidates to the total cost.
    // The problem guarantees a solution always exists, implying enough good_candidates will be found.
    for (int k = 0; k < needed_swaps_with_good; k++) {
        total_cost += good_candidates[k];
    }

    free(bad_vals_arr);
    free(good_candidates);

    return total_cost;
}