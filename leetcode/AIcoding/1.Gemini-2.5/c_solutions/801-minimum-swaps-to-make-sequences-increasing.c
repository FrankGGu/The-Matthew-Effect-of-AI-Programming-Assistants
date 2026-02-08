#include <limits.h> // For INT_MAX, though n+1 is used instead
#include <stdlib.h> // For min, or custom min function

static inline int min(int a, int b) {
    return a < b ? a : b;
}

int minSwap(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;

    // dp[i][0]: min swaps to make sequences increasing up to index i, without swapping nums1[i] and nums2[i]
    // dp[i][1]: min swaps to make sequences increasing up to index i, with swapping nums1[i] and nums2[i]

    // Space optimized to O(1)
    // prevNoSwap: represents dp[i-1][0]
    // prevSwap: represents dp[i-1][1]
    int prevNoSwap = 0; // Base case for i=0: 0 swaps if not swapped
    int prevSwap = 1;   // Base case for i=0: 1 swap if swapped

    // Using n+1 as a representation of infinity, since max swaps can be n.
    // This avoids potential INT_MAX + 1 overflow issues and is large enough.
    int INF = n + 1;

    for (int i = 1; i < n; i++) {
        int currNoSwap = INF;
        int currSwap = INF;

        // Option 1: Consider the state where (i-1) was NOT swapped (cost prevNoSwap)
        //   Sub-option 1.1: Do NOT swap at current index i.
        //     Requires: nums1[i] > nums1[i-1] AND nums2[i] > nums2[i-1]
        if (nums1[i] > nums1[i-1] && nums2[i] > nums2[i-1]) {
            currNoSwap = min(currNoSwap, prevNoSwap);
        }

        //   Sub-option 1.2: DO swap at current index i.
        //     Requires: nums2[i] > nums1[i-1] AND nums1[i] > nums2[i-1]
        if (nums2[i] > nums1[i-1] && nums1[i] > nums2[i-1]) {
            currSwap = min(currSwap, prevNoSwap + 1);
        }

        // Option 2: Consider the state where (i-1) WAS swapped (cost prevSwap)
        //   Sub-option 2.1: Do NOT swap at current index i.
        //     Requires: nums1[i] > nums2[i-1] AND nums2[i] > nums1[i-1]
        if (nums1[i] > nums2[i-1] && nums2[i] > nums1[i-1]) {
            currNoSwap = min(currNoSwap, prevSwap);
        }

        //   Sub-option 2.2: DO swap at current index i.
        //     Requires: nums2[i] > nums2[i-1] AND nums1[i] > nums1[i-1]
        if (nums2[i] > nums2[i-1] && nums1[i] > nums1[i-1]) {
            currSwap = min(currSwap, prevSwap + 1);
        }

        prevNoSwap = currNoSwap;
        prevSwap = currSwap;
    }

    return min(prevNoSwap, prevSwap);
}