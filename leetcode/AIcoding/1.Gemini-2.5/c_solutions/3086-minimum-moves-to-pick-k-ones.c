#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MAX

long long minMoves(int* nums, int numsSize, int k) {
    // 1. Collect indices of all '1's
    // We allocate numsSize space, but only use 'm' elements.
    // This is safe as m <= numsSize.
    int* ones_indices = (int*)malloc(numsSize * sizeof(int));
    int m = 0; // Number of ones
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == 1) {
            ones_indices[m++] = i;
        }
    }

    // If k is greater than the number of ones, it's impossible to pick k ones.
    if (k > m) {
        free(ones_indices);
        return -1; 
    }

    // Special case for k=1, no moves needed as a single '1' is already "picked".
    if (k == 1) {
        free(ones_indices);
        return 0;
    }

    // 2. Transform indices to val_j = pos_j - j
    // This transformation helps in minimizing sum_abs(val_j - T) where T is the median.
    // The val array will be non-decreasing.
    long long* val = (long long*)malloc(m * sizeof(long long));
    for (int i = 0; i < m; ++i) {
        val[i] = (long long)ones_indices[i] - i;
    }

    // 3. Calculate prefix sums for the val array
    // pref_val_sum[x] stores the sum of val[0]...val[x-1]
    long long* pref_val_sum = (long long*)malloc((m + 1) * sizeof(long long));
    pref_val_sum[0] = 0;
    for (int i = 0; i < m; ++i) {
        pref_val_sum[i + 1] = pref_val_sum[i] + val[i];
    }

    long long min_cost = LLONG_MAX;

    // 4. Slide a window of size k over the val array
    // For each window, calculate the cost to bring the k ones together.
    // The optimal target value T for a window of val_j's is their median.
    for (int i = 0; i <= m - k; ++i) {
        // mid_idx_in_window is the index of the median element relative to the start of the current window.
        int mid_idx_in_window = k / 2;
        // mid_idx is the absolute index of the median element in the 'val' array.
        int mid_idx = i + mid_idx_in_window;
        long long median_val = val[mid_idx];

        // Number of elements to the left of the median (excluding median itself)
        long long num_left_elements = mid_idx_in_window;

        // Number of elements to the right of the median (excluding median itself)
        // Total elements in window is k.
        // k - 1 (excluding median itself) - num_left_elements
        long long num_right_elements = k - 1 - num_left_elements;

        // Sum of elements to the left of median in the current window
        // pref_val_sum[mid_idx] is sum up to val[mid_idx-1]
        // pref_val_sum[i] is sum up to val[i-1]
        long long left_sum = pref_val_sum[mid_idx] - pref_val_sum[i];

        // Sum of elements to the right of median in the current window
        // pref_val_sum[i+k] is sum up to val[i+k-1]
        // pref_val_sum[mid_idx+1] is sum up to val[mid_idx]
        long long right_sum = pref_val_sum[i + k] - pref_val_sum[mid_idx + 1];

        // Cost calculation: sum of abs(val[j] - median_val)
        // For elements to the left of median: (median_val - val[j])
        // For elements to the right of median: (val[j] - median_val)
        long long current_cost = num_left_elements * median_val - left_sum +
                                 right_sum - num_right_elements * median_val;

        if (current_cost < min_cost) {
            min_cost = current_cost;
        }
    }

    // Free dynamically allocated memory
    free(ones_indices);
    free(val);
    free(pref_val_sum);

    return min_cost;
}