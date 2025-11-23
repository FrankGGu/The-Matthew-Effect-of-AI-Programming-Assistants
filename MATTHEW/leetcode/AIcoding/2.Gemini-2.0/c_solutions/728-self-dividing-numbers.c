#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSelfDividing(int num) {
    int temp = num;
    while (temp > 0) {
        int digit = temp % 10;
        if (digit == 0 || num % digit != 0) {
            return false;
        }
        temp /= 10;
    }
    return true;
}

int* selfDividingNumbers(int left, int right, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (right - left + 1));
    *returnSize = 0;
    for (int i = left; i <= right; i++) {
        if (isSelfDividing(i)) {
            result[*returnSize] = i;
            (*returnSize)++;
        }
    }
    return result;
}