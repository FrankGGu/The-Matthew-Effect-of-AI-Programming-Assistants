#include <stdlib.h> // Required for malloc and free

long long* findThePowerOfKSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    // Handle edge cases: empty input array, invalid k, or k larger than array size.
    if (numsSize == 0 || k <= 0 || k > numsSize) {
        *returnSize = 0;
        return NULL;
    }

    // Define the modulo constant.
    long long MOD = 1e9 + 7;

    // Calculate the number of k-size subarrays, which determines the size of the result array.
    int resultSize = numsSize - k + 1;
    long long* ans = (long long*)malloc(resultSize * sizeof(long long));
    if (ans == NULL) {
        *returnSize = 0;
        return NULL;
    }
    *returnSize = resultSize;

    // Deque (double-ended queue) for efficiently finding the minimum element in a sliding window.
    // It stores indices of elements. The indices in the deque are in increasing order,
    // and the corresponding values in 'nums' are also in increasing order.
    // The maximum size of the deque is k.
    int* dq = (int*)malloc(k * sizeof(int));
    if (dq == NULL) {
        free(ans); // Free previously allocated memory if deque allocation fails.
        *returnSize = 0;
        return NULL;
    }
    int head = 0; // Pointer to the front of the deque (index of the smallest element in current window).
    int tail = 0; // Pointer to the back of the deque (next available position for new elements).

    long long currentSum = 0; // Variable to keep track of the sum of elements in the current sliding window.

    // Iterate through the input array to process sliding windows.
    for (int i = 0; i < numsSize; ++i) {
        // 1. Update the sliding window sum by adding the current element.
        currentSum += nums[i];

        // 2. Maintain the deque to ensure it correctly identifies the minimum element.
        // Remove elements from the back of the deque whose values are greater than or equal to nums[i].
        // This ensures that the deque only contains indices of potentially minimum elements,
        // ordered by their value (smallest at front) and by their index (smallest index first for ties).
        while (head < tail && nums[dq[tail - 1]] >= nums[i]) {
            tail--;
        }
        // Add the current element's index to the back of the deque.
        dq[tail++] = i;

        // 3. Once the window of size k is fully formed (i.e., when 'i' reaches k-1 or beyond).
        if (i >= k - 1) {
            // Remove elements from the front of the deque that are no longer within the current window.
            // The current window spans from index (i - k + 1) to 'i'.
            while (head < tail && dq[head] <= i - k) {
                head++;
            }

            // The minimum element in the current window is always at the front of the deque.
            long long minElement = nums[dq[head]];

            // Calculate the power: (sum of elements) * (minimum element), then apply modulo.
            // Use (val % MOD + MOD) % MOD to correctly handle potential negative intermediate results
            // from C's '%' operator if 'currentSum' or 'minElement' could be negative.
            long long sumMod = (currentSum % MOD + MOD) % MOD;
            long long minMod = (minElement % MOD + MOD) % MOD;

            long long power = (sumMod * minMod) % MOD;

            // Store the calculated power in the result array.
            // The result for the window ending at index 'i' corresponds to index 'i - (k - 1)' in 'ans'.
            ans[i - (k - 1)] = power;

            // 4. Slide the window forward: remove the element that is exiting the window from the sum.
            // The element leaving the window is nums[i - k + 1].
            currentSum -= nums[i - (k - 1)];
        }
    }

    // Free the dynamically allocated memory for the deque.
    free(dq);

    // Return the dynamically allocated result array.
    return ans;
}