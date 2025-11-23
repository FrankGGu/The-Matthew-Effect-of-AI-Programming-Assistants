#include <stdlib.h>
#include <limits.h>

static int min(int a, int b) {
    return a < b ? a : b;
}

static int calculate_ops(int* nums1, int* nums2, int n, int target1, int target2) {
    int operations = 0;
    for (int i = 0; i < n - 1; i++) {
        // Case 1: Both elements are already within their respective targets
        if (nums1[i] <= target1 && nums2[i] <= target2) {
            continue;
        }
        // Case 2: Both elements are too large, even if swapped, one would still be too large
        // (nums1[i] > target1 AND nums2[i] > target2)
        // If we don't swap, nums1[i] > target1 and nums2[i] > target2. Impossible.
        // If we swap, new nums1[i] is nums2[i], new nums2[i] is nums1[i].
        // Then nums2[i] > target1 and nums1[i] > target2. Impossible.
        if (nums1[i] > target1 && nums2[i] > target2) {
            return -1;
        }
        // Case 3: nums1[i] is too large, must swap
        // (nums1[i] > target1 AND nums2[i] <= target2 is implied if not Case 1 or 2)
        if (nums1[i] > target1) {
            // After swap: new nums1[i] = original nums2[i], new nums2[i] = original nums1[i]
            // Check if the new values satisfy the targets
            if (nums2[i] > target1 || nums1[i] > target2) {
                return -1; // Swap doesn't help or makes it worse
            }
            operations++;
        }
        // Case 4: nums2[i] is too large, must swap
        // (nums1[i] <= target1 AND nums2[i] > target2 is implied if not Case 1 or 2)
        else { // This means nums1[i] <= target1, but nums2[i] > target2
            // After swap: new nums1[i] = original nums2[i], new nums2[i] = original nums1[i]
            // Check if the new values satisfy the targets
            if (nums2[i] > target1 || nums1[i] > target2) {
                return -1; // Swap doesn't help or makes it worse
            }
            operations++;
        }
    }
    return operations;
}

int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int ans = INT_MAX;
    int res;

    // Scenario 1: The last elements (nums1[n-1], nums2[n-1]) are NOT swapped.
    // Use nums1[n-1] as target for nums1, and nums2[n-1] as target for nums2.
    int target1_s1 = nums1[n - 1];
    int target2_s1 = nums2[n - 1];
    res = calculate_ops(nums1, nums2, n, target1_s1, target2_s1);
    if (res != -1) {
        ans = min(ans, res);
    }

    // Scenario 2: The last elements (nums1[n-1], nums2[n-1]) ARE swapped.
    // Use nums2[n-1] as target for nums1, and nums1[n-1] as target for nums2.
    // This scenario costs 1 operation for the swap at index n-1.
    int target1_s2 = nums2[n - 1];
    int target2_s2 = nums1[n - 1];
    res = calculate_ops(nums1, nums2, n, target1_s2, target2_s2);
    if (res != -1) {
        ans = min(ans, res + 1); // Add 1 for the swap at index n-1
    }

    if (ans == INT_MAX) {
        return -1; // No valid solution found
    } else {
        return ans;
    }
}