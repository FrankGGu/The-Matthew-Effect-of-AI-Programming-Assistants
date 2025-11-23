#include <stdlib.h> // For abs
#include <string.h> // For memset

#define MAX_DIFF_VAL 100000

static int freq[MAX_DIFF_VAL + 1];

long long minSumSquareDifferences(int* nums1, int nums1Size, int* nums2, int nums2Size, int k1, int k2) {
    // Reset the frequency array for the current test case.
    memset(freq, 0, sizeof(freq));

    long long k_total = (long long)k1 + k2;
    int max_current_diff = 0;

    // Calculate initial absolute differences and populate the frequency array.
    // Also find the maximum difference encountered to optimize subsequent loops.
    for (int i = 0; i < nums1Size; i++) {
        int diff = abs(nums1[i] - nums2[i]);
        freq[diff]++;
        if (diff > max_current_diff) {
            max_current_diff = diff;
        }
    }

    // Distribute operations to reduce the largest differences first.
    // Iterate from the maximum difference down to 1.
    for (int d = max_current_diff; d > 0 && k_total > 0; d--) {
        if (freq[d] > 0) {
            if (k_total >= freq[d]) {
                // If we have enough operations to reduce all 'freq[d]' differences by 1,
                // apply them.
                k_total -= freq[d];
                freq[d - 1] += freq[d];
                freq[d] = 0;
            } else {
                // If we don't have enough operations, use all remaining 'k_total'
                // operations to reduce some of the 'freq[d]' differences by 1.
                freq[d - 1] += k_total;
                freq[d] -= k_total;
                k_total = 0; // All operations are used.
            }
        }
    }

    // Calculate the final sum of squared differences.
    long long sum_sq_diff = 0;
    for (int d = 0; d <= max_current_diff; d++) {
        if (freq[d] > 0) {
            sum_sq_diff += (long long)freq[d] * d * d;
        }
    }

    return sum_sq_diff;
}