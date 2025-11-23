#include <limits.h> // For INT_MIN

int maximizeTheTopmostElement(int* nums, int numsSize, int k) {
    // Case 1: Only one element in the stack
    if (numsSize == 1) {
        // If k is odd, we remove the only element, and the stack becomes empty.
        // We cannot put it back and end up with an element on top.
        // Example: nums = [100], k = 1. Remove 100. Stack empty. Result -1.
        // Example: nums = [100], k = 3. Remove 100, Add 100, Remove 100. Stack empty. Result -1.
        if (k % 2 == 1) {
            return -1;
        } else {
            // If k is even, we can remove and add nums[0] k/2 times.
            // Example: nums = [100], k = 0. 100 is on top. Result 100.
            // Example: nums = [100], k = 2. Remove 100, Add 100. 100 is on top. Result 100.
            return nums[0];
        }
    }

    // Case 2: No moves allowed
    if (k == 0) {
        return nums[0];
    }

    // Case 3: k is exactly numsSize. We remove all elements. The stack becomes empty.
    // We have no moves left to add any element back.
    // Example: nums = [1,2,3], k = 3. Remove 1, then 2, then 3. Stack empty. Result -1.
    if (k == numsSize) {
        return -1;
    }

    // General case: numsSize > 1, k > 0, k != numsSize.
    int max_val = INT_MIN;

    // Option A: Consider elements nums[i] that can be removed and put back on top.
    // To put nums[i] back on top:
    // 1. Remove elements nums[0] through nums[i-1] (i moves).
    // 2. Remove nums[i] (1 move).
    // Total moves so far: i+1. nums[i] is now "previously removed".
    // Remaining moves: k - (i+1).
    // 3. Add nums[i] back to the top (1 move).
    // Total moves so far: i+2.
    // Remaining moves: k - (i+2).
    // If k - (i+2) >= 0, we can use these remaining moves by repeatedly removing and
    // adding nums[i] itself, ensuring nums[i] remains on top.
    // So, this strategy is valid if i+2 <= k, which means i <= k-2.
    // We iterate for i from 0 up to min(numsSize - 1, k - 2).
    for (int i = 0; i < numsSize && i <= k - 2; ++i) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    // Option B: Consider the element that becomes topmost after exactly k removals.
    // This happens if we remove nums[0] through nums[k-1].
    // This takes exactly k moves. The element nums[k] will then be on top.
    // This is only possible if nums[k] exists, i.e., k < numsSize.
    if (k < numsSize) {
        if (nums[k] > max_val) {
            max_val = nums[k];
        }
    }

    return max_val;
}