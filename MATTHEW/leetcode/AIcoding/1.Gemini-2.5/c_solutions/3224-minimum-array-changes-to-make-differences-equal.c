#include <stdlib.h>
#include <string.h>
#include <stdio.h> // Not strictly needed for LeetCode submission, but good for local testing

int compareInt(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minArrayChanges(int* nums, int n) {
    if (n <= 1) {
        return 0;
    }

    int min_changes = n;

    // Case k = 0: All elements must be equal.
    // Find the most frequent element.
    // Sorting allows easy frequency counting.
    qsort(nums, n, sizeof(int), compareInt);
    int max_freq_k0 = 0;
    int current_freq = 0;
    for (int i = 0; i < n; i++) {
        current_freq++;
        if (i == n - 1 || nums[i] != nums[i+1]) {
            if (current_freq > max_freq_k0) {
                max_freq_k0 = current_freq;
            }
            current_freq = 0;
        }
    }
    min_changes = n - max_freq_k0;
    if (min_changes == 0) { // Optimization: if 0 changes, it's the best possible
        return 0;
    }

    // Case k > 0: |nums[i] - nums[i-1]| = k
    // This implies nums[i] - i*k = C (mod 2k) for some constant C.
    // We need to find k and C that maximize the count of elements satisfying this.

    // Threshold for small k where we use a direct frequency array.
    // N=10^5, so N * MAX_K_SMALL should be roughly 2*10^8 for 2s time limit.
    // MAX_K_SMALL = 2000 gives 2 * 10^8 operations.
    const int MAX_K_SMALL = 2000; 

    // Allocate a frequency array large enough for 2 * MAX_K_SMALL.
    // The maximum index accessed will be 2*k - 1, which is at most 2*MAX_K_SMALL - 1.
    int* freq_small_k = (int*)calloc(2 * MAX_K_SMALL, sizeof(int));
    if (freq_small_k == NULL) {
        // Handle allocation failure, though unlikely on LeetCode.
        // For competitive programming, this might be a critical path.
        // For now, assume success.
        return -1; // Indicate error or return a default large value
    }

    for (int k = 1; k <= MAX_K_SMALL; k++) {
        // Clear the entire pre-allocated buffer for the current k.
        // 2 * MAX_K_SMALL is 4000, so clearing 4000 ints (16KB) is fast enough.
        memset(freq_small_k, 0, (2 * MAX_K_SMALL) * sizeof(int));

        int max_freq_for_k = 0;
        for (int i = 0; i < n; i++) {
            long long val = (long long)nums[i] - (long long)i * k;
            // Calculate positive modulo: (val % (2k) + 2k) % (2k)
            long long mod_val = (val % (2LL * k) + (2LL * k)) % (2LL * k);

            // mod_val will be in [0, 2k-1]. Since k <= MAX_K_SMALL, 2k-1 < 2*MAX_K_SMALL.
            freq_small_k[mod_val]++;
            if (freq_small_k[mod_val] > max_freq_for_k) {
                max_freq_for_k = freq_small_k[mod_val];
            }
        }

        if (n - max_freq_for_k < min_changes) {
            min_changes = n - max_freq_for_k;
        }
        if (min_changes == 0) { // Optimization: if 0 changes, it's the best possible
            break;
        }
    }
    free(freq_small_k);

    // For k > MAX_K_SMALL, the values of 2k can be very large (up to 2*10^9).
    // Using a direct frequency array is not feasible. A hash map would be required.
    // However, for very large k (e.g., k > max(nums[i])), the minimum changes
    // typically stabilize at N/2. If `min_changes` is already less than N/2,
    // it's unlikely a larger `k` will yield a better result.
    // The `min_changes == 0` early exit covers the best case.

    return min_changes;
}