#include <math.h>   // For fmax
#include <limits.h> // For LLONG_MIN

int kConcatenationMaxSum(int* arr, int arrSize, int k) {
    long long MOD = 1e9 + 7;

    // --- Step 1: Kadane's algorithm for a single array ---
    // This version of Kadane's allows an empty subarray (sum 0).
    // It will be 0 if all elements are negative.
    long long current_max_kadane = 0;
    long long max_single_kadane = 0;

    // To handle the case where all elements are negative (max sum is the largest negative number)
    long long max_val_in_arr = LLONG_MIN; 

    for (int i = 0; i < arrSize; i++) {
        max_val_in_arr = fmax(max_val_in_arr, arr[i]);
        current_max_kadane += arr[i];
        if (current_max_kadane < 0) {
            current_max_kadane = 0;
        }
        max_single_kadane = fmax(max_single_kadane, current_max_kadane);
    }

    // If all numbers in the array are negative, the maximum sum of any non-empty subarray
    // is simply the largest (least negative) number.
    // In this specific case, max_single_kadane (which allows sum 0) would be 0.
    // We adjust it here to return the largest negative number if applicable.
    if (max_val_in_arr < 0) {
        return (int)(max_val_in_arr % MOD);
    }

    // --- Step 2: Calculate total sum of the array ---
    long long arr_sum = 0;
    for (int i = 0; i < arrSize; i++) {
        arr_sum += arr[i];
    }

    // --- Step 3: Calculate maximum prefix sum ---
    // We only care about positive prefix sums that can extend a subarray.
    long long current_prefix_sum = 0;
    long long max_prefix_sum = 0;
    for (int i = 0; i < arrSize; i++) {
        current_prefix_sum += arr[i];
        max_prefix_sum = fmax(max_prefix_sum, current_prefix_sum);
    }

    // --- Step 4: Calculate maximum suffix sum ---
    // We only care about positive suffix sums that can extend a subarray.
    long long current_suffix_sum = 0;
    long long max_suffix_sum = 0;
    for (int i = arrSize - 1; i >= 0; i--) {
        current_suffix_sum += arr[i];
        max_suffix_sum = fmax(max_suffix_sum, current_suffix_sum);
    }

    // --- Step 5: Determine the final maximum sum based on k ---
    long long result = max_single_kadane; // Base case: max sum within a single array

    if (k == 1) {
        // Already covered by max_single_kadane
    } else { // k > 1
        // Case A: The maximum subarray spans across exactly two original arrays.
        // This is formed by the max suffix sum of the first array + max prefix sum of the second array.
        long long sum_two_arrays = max_prefix_sum + max_suffix_sum;
        result = fmax(result, sum_two_arrays);

        // Case B: The maximum subarray spans across more than two original arrays.
        // This is only beneficial if the total sum of the array (arr_sum) is positive.
        // It's formed by max suffix sum + (k-2 full arrays) + max prefix sum.
        if (arr_sum > 0) {
            long long sum_multiple_arrays = max_prefix_sum + (arr_sum * (k - 2)) + max_suffix_sum;
            result = fmax(result, sum_multiple_arrays);
        }
    }

    return (int)(result % MOD);
}