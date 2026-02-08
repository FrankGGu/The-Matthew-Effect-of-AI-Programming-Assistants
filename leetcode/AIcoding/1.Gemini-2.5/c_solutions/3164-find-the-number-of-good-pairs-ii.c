#include <stdlib.h> // For calloc, free

#define MAX_VAL_PLUS_ONE 1000001

long long numberOfGoodPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    long long goodPairsCount = 0;

    // Special case: if k is 0
    // The condition becomes nums1[i] == nums2[j] * 0, which simplifies to nums1[i] == 0.
    // If nums1[i] is 0, it forms a good pair with every element in nums2.
    // If nums1[i] is not 0, it forms no good pairs.
    if (k == 0) {
        long long zerosInNums1 = 0;
        for (int i = 0; i < nums1Size; ++i) {
            if (nums1[i] == 0) {
                zerosInNums1++;
            }
        }
        return zerosInNums1 * nums2Size;
    }

    // Case: k > 0
    // We need to count occurrences of target values in nums2 efficiently.
    // A frequency array (hash map) is suitable for this.
    // Allocate a frequency array for nums2 values, initialized to zeros.
    // calloc ensures all elements are 0.
    int* freq2 = (int*)calloc(MAX_VAL_PLUS_ONE, sizeof(int));
    // In competitive programming, we typically assume memory allocation succeeds.
    // For robust production code, one would check if (freq2 == NULL).

    // Populate the frequency array for nums2
    for (int i = 0; i < nums2Size; ++i) {
        // nums2[i] is guaranteed to be within [0, 10^6], so it's a valid index.
        freq2[nums2[i]]++;
    }

    // Iterate through nums1 to find good pairs
    for (int i = 0; i < nums1Size; ++i) {
        int num1_val = nums1[i];

        // For a good pair, nums1[i] must be divisible by k.
        if (num1_val % k == 0) {
            // Calculate the required value for nums2[j]
            int target_nums2_val = num1_val / k;

            // Check if this target value is within the valid range for nums2 elements
            // and thus a valid index for freq2.
            // Since nums1[i] <= 10^6 and k >= 1, target_nums2_val = nums1[i] / k will always be <= 10^6.
            // So, target_nums2_val will always be a valid index for freq2.
            goodPairsCount += freq2[target_nums2_val];
        }
    }

    // Free the dynamically allocated memory
    free(freq2);

    return goodPairsCount;
}