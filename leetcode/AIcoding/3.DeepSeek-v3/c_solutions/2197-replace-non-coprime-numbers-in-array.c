#include <stdlib.h>

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

long long lcm(long long a, long long b) {
    return a / gcd(a, b) * b;
}

int* replaceNonCoprimes(int* nums, int numsSize, int* returnSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        long long current = nums[i];

        while (top >= 0) {
            int gcd_val = gcd(stack[top], current);
            if (gcd_val == 1) break;

            current = lcm(stack[top], current);
            top--;
        }

        stack[++top] = current;
    }

    *returnSize = top + 1;
    int* result = (int*)malloc((*returnSize) * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = stack[i];
    }

    free(stack);
    return result;
}