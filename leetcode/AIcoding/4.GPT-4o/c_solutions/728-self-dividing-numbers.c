#include <stdio.h>
#include <stdlib.h>

int* selfDividingNumbers(int left, int right, int* returnSize) {
    int* result = (int*)malloc((right - left + 1) * sizeof(int));
    *returnSize = 0;

    for (int i = left; i <= right; i++) {
        int num = i, isSelfDividing = 1;
        while (num > 0) {
            int digit = num % 10;
            if (digit == 0 || i % digit != 0) {
                isSelfDividing = 0;
                break;
            }
            num /= 10;
        }
        if (isSelfDividing) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}