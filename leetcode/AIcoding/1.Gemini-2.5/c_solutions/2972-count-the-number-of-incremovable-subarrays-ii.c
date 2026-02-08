#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

long long incremovableSubarrayCount(int* nums, int numsSize) {
    int n = numsSize;
    if (n == 0) {
        return 0;
    }

    bool* prefix_ok = (bool*)malloc((n + 1) * sizeof(bool));
    bool* suffix_ok = (bool*)malloc((n + 1) * sizeof(bool));

    // prefix_ok[len] is true if nums[0...len-1] is strictly increasing
    prefix_ok[0] = true;
    for (int len = 1; len <= n; ++len) {
        prefix_ok[len] = prefix_ok[len - 1] && (len == 1 || nums[len - 1] > nums[len - 2]);
    }

    // suffix_ok[start_idx] is true if nums[start_idx...n-1] is strictly increasing
    suffix_ok[n] = true;
    for (int start_idx = n - 1; start_idx >= 0; --start_idx) {
        suffix_ok[start_idx] = suffix_ok[start_idx + 1] && (start_idx == n - 1 || nums[start_idx] < nums[start_idx + 1]);
    }

    long long ans = 0;
    int k = 0; // k is the starting index of the suffix (j+1)

    for (int i = 0; i < n; ++i) { // i is the starting index of the removed subarray
        // Check if prefix nums[0...i-1] is strictly increasing
        if (!prefix_ok[i]) {
            break; 
        }

        int left_val = (i == 0) ? -1 : nums[i - 1]; // Sentinel for empty prefix

        // Ensure k (suffix start) is at least i+1 (since j >= i, so j+1 >= i+1)
        k = (k > i + 1) ? k : (i + 1);

        // Find the smallest k (suffix start) that satisfies conditions
        while (k <= n) {
            bool current_suffix_valid = suffix_ok[k];
            bool boundary_condition_met = true;

            if (i > 0 && k < n) { // If both prefix and suffix are non-empty
                if (left_val >= nums[k]) {
                    boundary_condition_met = false;
                }
            }

            if (current_suffix_valid && boundary_condition_met) {
                // This k is the smallest valid suffix start for the current i.
                // All k' from k to n are also valid suffix starts.
                // Each such k' corresponds to a j = k' - 1.
                // The number of such valid j's is (n - 1) - (k - 1) + 1 = n - k + 1.
                ans += (n - k + 1);
                break; // Found the smallest valid k for this i, move to next i
            }
            k++; // Try next suffix start
        }

        if (k > n) { // No valid suffix start found for this i
            // Since i is increasing, nums[i-1] is increasing, making the boundary condition harder to satisfy.
            // If no k is found for current i, no k will be found for larger i.
            break;
        }
    }

    free(prefix_ok);
    free(suffix_ok);

    return ans;
}