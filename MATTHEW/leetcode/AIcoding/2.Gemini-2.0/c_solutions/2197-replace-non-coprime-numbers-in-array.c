#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int* replaceNonCoprimes(int* nums, int numsSize, int* returnSize) {
    int* stack = (int*)malloc(sizeof(int) * numsSize);
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        while (top >= 0 && gcd(stack[top], num) > 1) {
            num = (long long)stack[top] * num / gcd(stack[top], num);
            top--;
        }
        stack[++top] = num;
    }

    *returnSize = top + 1;
    return stack;
}