#include <stdlib.h> // For malloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int validSubarraySize(int* nums, int numsSize, int threshold) {
    int n = numsSize;

    // Arrays to store indices of previous smaller and next smaller elements
    // left[i] stores the index of the first element to the left of i that is strictly smaller than nums[i].
    // If no such element exists, left[i] is -1.
    int* left = (int*)malloc(n * sizeof(int));

    // right[i] stores the index of the first element to the right of i that is strictly smaller than nums[i].
    // If no such element exists, right[i] is n.
    int* right = (int*)malloc(n * sizeof(int));

    // Stack for monotonic stack operations. Stores indices.
    int* stack = (int*)malloc(n * sizeof(int));
    int stack_top = -1; // -1 indicates an empty stack

    // Calculate left array (previous smaller element)
    for (int i = 0; i < n; ++i) {
        // Pop elements from stack that are greater than or equal to nums[i]
        // because they cannot be the previous smaller element for future elements
        // and nums[i] is the previous smaller for them (if it were smaller).
        while (stack_top != -1 && nums[stack[stack_top]] >= nums[i]) {
            stack_top--;
        }
        // If stack is empty, no smaller element to the left
        if (stack_top == -1) {
            left[i] = -1;
        } else {
            // The top of the stack is the index of the previous smaller element
            left[i] = stack[stack_top];
        }
        // Push current index onto the stack
        stack_top++;
        stack[stack_top] = i;
    }

    // Reset stack for right array calculation
    stack_top = -1;

    // Calculate right array (next smaller element)
    // Iterate from right to left
    for (int i = n - 1; i >= 0; --i) {
        // Pop elements from stack that are greater than or equal to nums[i]
        while (stack_top != -1 && nums[stack[stack_top]] >= nums[i]) {
            stack_top--;
        }
        // If stack is empty, no smaller element to the right
        if (stack_top == -1) {
            right[i] = n;
        } else {
            // The top of the stack is the index of the next smaller element
            right[i] = stack[stack_top];
        }
        // Push current index onto the stack
        stack_top++;
        stack[stack_top] = i;
    }

    int max_k = 0;

    // Iterate through each element nums[i] and consider it as the minimum
    // element in a potential valid subarray.
    for (int i = 0; i < n; ++i) {
        // The length of the subarray where nums[i] is the minimum element
        // is (right[i] - 1) - (left[i] + 1) + 1 = right[i] - left[i] - 1.
        // This subarray spans from index (left[i] + 1) to (right[i] - 1).
        long long current_length = (long long)right[i] - left[i] - 1;

        // Check the condition: nums[i] > current_length * threshold
        // If nums[i] is the minimum in a subarray of length 'current_length',
        // and nums[i] itself satisfies the condition, then all elements in that subarray
        // (which are >= nums[i]) also satisfy the condition.
        // Use long long for the product to prevent overflow, as current_length * threshold
        // can be up to 10^5 * 10^9 = 10^14.
        if ((long long)nums[i] > current_length * threshold) {
            max_k = max(max_k, (int)current_length);
        }
    }

    // Free dynamically allocated memory
    free(left);
    free(right);
    free(stack);

    return max_k;
}