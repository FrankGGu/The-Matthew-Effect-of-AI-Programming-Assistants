#include <stdbool.h>
#include <stdlib.h> // For malloc and free

int incremovableSubarrayCount(int* nums, int numsSize) {
    int n = numsSize;
    int count = 0;

    // prefix_ok[k] is true if nums[0...k-1] is strictly increasing.
    // Size n+1 to handle empty prefix (k=0) and full prefix (k=n).
    bool* prefix_ok = (bool*)malloc((n + 1) * sizeof(bool));
    // In a competitive programming context like LeetCode, malloc failure is usually not tested
    // for small N, but it's good practice to check.
    if (prefix_ok == NULL) {
        return 0; 
    }

    prefix_ok[0] = true; // Empty prefix nums[0...-1] is strictly increasing.
    for (int k = 1; k <= n; ++k) {
        if (k == 1) {
            prefix_ok[k] = true; // A single element prefix nums[0] is strictly increasing.
        } else {
            // Check if nums[0...k-2] was strictly increasing AND nums[k-1] > nums[k-2].
            prefix_ok[k] = prefix_ok[k-1] && (nums[k-1] > nums[k-2]);
        }
    }

    // suffix_ok[k] is true if nums[k...n-1] is strictly increasing.
    // Size n+1 to handle empty suffix (k=n) and full suffix (k=0).
    bool* suffix_ok = (bool*)malloc((n + 1) * sizeof(bool));
    if (suffix_ok == NULL) {
        free(prefix_ok); // Clean up previously allocated memory
        return 0;
    }

    suffix_ok[n] = true; // Empty suffix nums[n...n-1] is strictly increasing.
    for (int k = n - 1; k >= 0; --k) {
        if (k == n - 1) {
            suffix_ok[k] = true; // A single element suffix nums[n-1] is strictly increasing.
        } else {
            // Check if nums[k+1...n-1] was strictly increasing AND nums[k] < nums[k+1].
            suffix_ok[k] = suffix_ok[k+1] && (nums[k] < nums[k+1]);
        }
    }

    // Iterate over all possible subarrays to remove: nums[i...j]
    // 'i' is the starting index of the subarray to remove.
    // 'j' is the ending index of the subarray to remove.
    for (int i = 0; i < n; ++i) {
        // Optimization: If the prefix nums[0...i-1] is not strictly increasing,
        // then any subarray removed starting at 'i' or later will result in an invalid prefix.
        // Thus, we can break the outer loop.
        if (!prefix_ok[i]) {
            break; 
        }

        for (int j = i; j < n; ++j) {
            // Check if the suffix nums[j+1...n-1] is strictly increasing.
            if (!suffix_ok[j+1]) {
                // If not, this specific (i,j) removal is invalid.
                // We cannot break the inner loop because a different 'j'' might have a valid suffix.
                // So, we just continue to the next 'j'.
                continue; 
            }

            // Check the connection condition: nums[i-1] < nums[j+1].
            // This condition is only relevant if both the prefix (before i) and suffix (after j) are non-empty.
            if (i > 0 && j < n - 1) {
                if (nums[i-1] >= nums[j+1]) {
                    continue; // Invalid connection.
                }
            }

            // If all checks pass, the subarray nums[i...j] is incremovable.
            count++;
        }
    }

    free(prefix_ok);
    free(suffix_ok);

    return count;
}