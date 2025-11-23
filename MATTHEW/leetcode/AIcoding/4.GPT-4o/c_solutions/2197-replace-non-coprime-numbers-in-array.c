#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int* replaceNonCoprimeNumbers(int* nums, int numsSize, int* returnSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = 0;

    for (int i = 0; i < numsSize; i++) {
        while (top > 0 && gcd(stack[top - 1], nums[i]) > 1) {
            nums[i] = (nums[i] / gcd(stack[top - 1], nums[i])) * stack[top - 1];
            top--;
        }
        stack[top++] = nums[i];
    }

    *returnSize = top;
    return stack;
}