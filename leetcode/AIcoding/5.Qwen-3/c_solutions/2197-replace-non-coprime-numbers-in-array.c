#include <stdio.h>
#include <stdlib.h>

int* replaceNonCoprimes(int* nums, int numsSize, int* returnSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        int current = nums[i];
        while (top >= 0) {
            int prev = stack[top];
            int gcd_val = __gcd(prev, current);
            if (gcd_val == 1) {
                break;
            }
            current = prev / gcd_val * current;
            top--;
        }
        stack[++top] = current;
    }

    *returnSize = top + 1;
    return stack;
}