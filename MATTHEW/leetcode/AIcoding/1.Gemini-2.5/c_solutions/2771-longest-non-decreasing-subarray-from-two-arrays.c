#include <stdlib.h> // Required for max function (or define custom one)

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int longestNonDecreasingSubarray(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    // If the array is empty, the longest subarray length is 0.
    // Problem constraints state nums1Size >= 1, so this check might not be strictly necessary.
    if (nums1Size == 0) {
        return 0;
    }

    // prev0: length of the longest non-decreasing subarray ending at the previous index (i-1),
    //        where nums1[i-1] was chosen.
    // prev1: length of the longest non-decreasing subarray ending at the previous index (i-1),
    //        where nums2[i-1] was chosen.
    int prev0 = 1;
    int prev1 = 1;

    // max_len: stores the overall maximum length found so far.
    // Initialize with 1, as a single element itself forms a non-decreasing subarray of length 1.
    int max_len = 1;

    // Iterate from the second element to the end of the arrays.
    for (int i = 1; i < nums1Size; i++) {
        // curr0: length of the longest non-decreasing subarray ending at the current index (i),
        //        where nums1[i] is chosen.
        // curr1: length of the longest non-decreasing subarray ending at the current index (i),
        //        where nums2[i] is chosen.
        // Initialize to 1, as nums1[i] or nums2[i] alone forms a subarray of length 1.
        int curr0 = 1;
        int curr1 = 1;

        // Calculate curr0 (ending with nums1[i]):
        // Option 1: Extend a subarray that ended with nums1[i-1].
        if (nums1[i] >= nums1[i-1]) {
            curr0 = max(curr0, prev0 + 1);
        }
        // Option 2: Extend a subarray that ended with nums2[i-1].
        if (nums1[i] >= nums2[i-1]) {
            curr0 = max(curr0, prev1 + 1);
        }

        // Calculate curr1 (ending with nums2[i]):
        // Option 1: Extend a subarray that ended with nums1[i-1].
        if (nums2[i] >= nums1[i-1]) {
            curr1 = max(curr1, prev0 + 1);
        }
        // Option 2: Extend a subarray that ended with nums2[i-1].
        if (nums2[i] >= nums2[i-1]) {
            curr1 = max(curr1, prev1 + 1);
        }

        // Update the overall maximum length with the current maximums.
        max_len = max(max_len, max(curr0, curr1));

        // Update previous states for the next iteration.
        prev0 = curr0;
        prev1 = curr1;
    }

    return max_len;
}