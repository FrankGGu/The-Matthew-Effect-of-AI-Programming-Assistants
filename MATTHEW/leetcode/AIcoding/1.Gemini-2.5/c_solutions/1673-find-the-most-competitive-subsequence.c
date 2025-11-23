#include <stdlib.h>

int* mostCompetitive(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = k;
    int* stack = (int*)malloc(sizeof(int) * k);
    int stack_ptr = 0; // Represents the current size of the stack and the index for the next element

    for (int i = 0; i < numsSize; i++) {
        while (stack_ptr > 0 && stack[stack_ptr - 1] > nums[i] && (stack_ptr - 1) + (numsSize - i) >= k) {
            stack_ptr--;
        }

        if (stack_ptr < k) {
            stack[stack_ptr] = nums[i];
            stack_ptr++;
        }
    }

    return stack;
}