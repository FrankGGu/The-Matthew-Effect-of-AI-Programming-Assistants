#include <stdio.h>
#include <stdlib.h>

int* selfDividingNumbers(int left, int right, int* returnSize) {
    int* result = (int*)malloc((right - left + 1) * sizeof(int));
    int index = 0;

    for (int num = left; num <= right; num++) {
        int n = num;
        int isSelfDividing = 1;

        while (n > 0) {
            int digit = n % 10;
            if (digit == 0 || num % digit != 0) {
                isSelfDividing = 0;
                break;
            }
            n /= 10;
        }

        if (isSelfDividing) {
            result[index++] = num;
        }
    }

    *returnSize = index;
    return result;
}