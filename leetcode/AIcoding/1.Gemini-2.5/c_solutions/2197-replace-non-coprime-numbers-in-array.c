#include <stdlib.h> // For malloc, free

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int* replaceNonCoprimes(int* nums, int numsSize, int* returnSize) {
    int* stack = (int*)malloc(sizeof(int) * numsSize);
    int stackTop = 0;

    for (int i = 0; i < numsSize; ++i) {
        int currentNum = nums[i];

        while (stackTop > 0) {
            int topElement = stack[stackTop - 1];
            int commonDivisor = gcd(topElement, currentNum);

            if (commonDivisor == 1) {
                break;
            } else {
                stackTop--;
                currentNum = (int)(((long long)topElement * currentNum) / commonDivisor);
            }
        }
        stack[stackTop++] = currentNum;
    }

    *returnSize = stackTop;
    int* result = (int*)malloc(sizeof(int) * stackTop);
    for (int i = 0; i < stackTop; ++i) {
        result[i] = stack[i];
    }

    free(stack);

    return result;
}