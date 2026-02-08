#include <stdlib.h>

int* maxSlidingWindow(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize == 0 || k == 0) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    if (result == NULL) {
        return NULL;
    }

    int* deque = (int*)malloc(numsSize * sizeof(int));
    if (deque == NULL) {
        free(result);
        return NULL;
    }
    int head = 0;
    int tail = 0;

    int result_idx = 0;

    for (int i = 0; i < numsSize; ++i) {
        // Remove indices from the front of the deque if they are out of the current window
        // The current window covers indices [i - k + 1, i]
        while (head < tail && deque[head] < i - k + 1) {
            head++;
        }

        // Remove indices from the back of the deque if their corresponding values
        // are less than or equal to the current element's value.
        // This maintains the property that elements in the deque are in decreasing order.
        while (head < tail && nums[deque[tail - 1]] <= nums[i]) {
            tail--;
        }

        // Add the current element's index to the back of the deque
        deque[tail++] = i;

        // If the window has fully formed (i.e., we have processed at least k elements),
        // the maximum element for the current window is at the front of the deque.
        if (i >= k - 1) {
            result[result_idx++] = nums[deque[head]];
        }
    }

    free(deque);
    return result;
}