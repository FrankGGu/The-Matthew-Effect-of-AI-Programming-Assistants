#include <stdlib.h> // For malloc, free
#include <string.h> // For memcpy
#include <limits.h> // For INT_MAX

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int calculate_cost(int* nums, int numsSize, int even_indices_are_peaks) {
    if (numsSize <= 1) {
        return 0;
    }

    int cost = 0;
    int* arr = (int*)malloc(numsSize * sizeof(int));
    memcpy(arr, nums, numsSize * sizeof(int));

    for (int i = 0; i < numsSize; ++i) {
        // Determine if current index 'i' should be a peak for this pattern
        // If even_indices_are_peaks is true, then even indices are peaks, odd indices are valleys.
        // If even_indices_are_peaks is false, then odd indices are peaks, even indices are valleys.
        int is_current_peak = (i % 2 == 0) == even_indices_are_peaks;

        if (is_current_peak) {
            // arr[i] must be a peak: arr[i] > arr[i-1] and arr[i] > arr[i+1]
            // To satisfy this by decreasing elements, we can decrease arr[i-1] or arr[i+1].
            // The current arr[i] value is taken as the reference.
            int current_val = arr[i];
            int max_allowed_neighbor_val = current_val - 1; // Neighbors must be at most this value

            // Check left neighbor
            if (i > 0) {
                int left_neighbor_val = arr[i-1];
                if (left_neighbor_val >= current_val) { // If left neighbor is too large
                    int decrease_amount = left_neighbor_val - max_allowed_neighbor_val;
                    cost += decrease_amount;
                    arr[i-1] = max_allowed_neighbor_val; // Modify neighbor in place
                }
            }

            // Check right neighbor
            if (i < numsSize - 1) {
                int right_neighbor_val = arr[i+1];
                if (right_neighbor_val >= current_val) { // If right neighbor is too large
                    int decrease_amount = right_neighbor_val - max_allowed_neighbor_val;
                    cost += decrease_amount;
                    arr[i+1] = max_allowed_neighbor_val; // Modify neighbor in place
                }
            }
        } else {
            // arr[i] must be a valley: arr[i] < arr[i-1] and arr[i] < arr[i+1]
            // To satisfy this by decreasing elements, we must decrease arr[i] itself if it's too large.
            // The neighbors arr[i-1] and arr[i+1] are taken as references.
            int current_val = arr[i];

            // Determine the minimum value its neighbors can take.
            // If a neighbor doesn't exist, it effectively imposes no lower bound on itself,
            // but for arr[i] to be a valley, it must be smaller than its existing neighbors.
            // Use INT_MAX for non-existent neighbors, so min(left, right) correctly picks the existing one.
            int left_neighbor_val = (i > 0) ? arr[i-1] : INT_MAX;
            int right_neighbor_val = (i < numsSize - 1) ? arr[i+1] : INT_MAX;

            // arr[i] must be strictly less than min(left_neighbor_val, right_neighbor_val)
            // So, target value for arr[i] is min(left_neighbor_val, right_neighbor_val) - 1.
            int target_val_for_current = min(left_neighbor_val, right_neighbor_val) - 1;

            // Elements must be at least 1. So, target_val_for_current cannot be less than 1.
            target_val_for_current = max(1, target_val_for_current);

            if (current_val >= target_val_for_current) { // If current element is too large
                int moves = current_val - target_val_for_current;
                cost += moves;
                arr[i] = target_val_for_current; // Decrease current element
            }
        }
    }

    free(arr);
    return cost;
}

int movesToMakeZigzag(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    // Scenario 1: Even indices are peaks (A[0] > A[1] < A[2] > ...)
    int cost1 = calculate_cost(nums, numsSize, 1);

    // Scenario 2: Odd indices are peaks (A[0] < A[1] > A[2] < ...)
    int cost2 = calculate_cost(nums, numsSize, 0);

    return min(cost1, cost2);
}