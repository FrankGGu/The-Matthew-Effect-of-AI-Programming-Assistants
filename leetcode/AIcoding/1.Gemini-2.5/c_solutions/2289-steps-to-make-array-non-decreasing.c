#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int totalSteps(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    // dp[i] stores the number of steps it takes for nums[i] to be removed.
    // If nums[i] is never removed, dp[i] remains 0.
    int* dp = (int*)calloc(numsSize, sizeof(int));
    if (dp == NULL) {
        // Handle memory allocation failure
        return -1; 
    }

    // Monotonic stack stores indices of elements that are currently non-decreasing
    // from left to right.
    // Elements on the stack are candidates to be the "left neighbor" that removes
    // subsequent smaller elements.
    int* stack_indices = (int*)malloc(sizeof(int) * numsSize);
    if (stack_indices == NULL) {
        free(dp);
        return -1;
    }
    int stack_top = -1; // Represents the top of the stack

    int ans = 0;

    for (int i = 0; i < numsSize; ++i) {
        int current_steps = 0;

        // While stack is not empty and the element at stack_top is less than or equal to nums[i]:
        while (stack_top != -1 && nums[stack_indices[stack_top]] <= nums[i]) {
            // If nums[stack_top] is strictly less than nums[i], it means nums[i] will eventually
            // remove nums[stack_top]. The number of steps for this removal will be
            // dp[stack_top] + 1 (1 for nums[stack_top] itself, and dp[stack_top] for elements
            // nums[stack_top] was responsible for removing).
            // We take the maximum because nums[i] needs to wait for all such elements it removes
            // to be gone.
            if (nums[stack_indices[stack_top]] < nums[i]) {
                current_steps = max(current_steps, dp[stack_indices[stack_top]] + 1);
            } else { // nums[stack_indices[stack_top]] == nums[i]
                // If nums[stack_top] is equal to nums[i], then nums[i] will not be removed
                // by nums[stack_top], nor will nums[i] remove nums[stack_top].
                // This means the chain of removals that nums[stack_top] might have been part of
                // is broken or reset for nums[i]. So, current_steps for nums[i] is 0.
                current_steps = 0;
            }
            stack_top--; // Pop the element from the stack
        }

        // After the loop, if the stack is not empty, it means nums[stack_top] > nums[i].
        // In this case, nums[i] will eventually be removed by nums[stack_top].
        // The number of steps for nums[i] to be removed is the 'current_steps' we calculated.
        if (stack_top != -1) {
            dp[i] = current_steps;
        } else {
            // If the stack is empty, nums[i] is the largest element encountered so far
            // (or the first element). It will not be removed by any element to its left.
            // So, its removal steps are 0.
            dp[i] = 0;
        }

        // Push current element's index onto the stack.
        stack_top++;
        stack_indices[stack_top] = i;

        // Update the overall maximum steps.
        ans = max(ans, dp[i]);
    }

    free(dp);
    free(stack_indices);
    return ans;
}