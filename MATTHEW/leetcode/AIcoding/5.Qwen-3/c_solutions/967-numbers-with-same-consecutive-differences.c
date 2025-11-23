#include <stdio.h>
#include <stdlib.h>

int* numDupDigitsAtMostN(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int index = 0;

    for (int i = 1; i <= n; i++) {
        int num = i;
        int prevDigit = -1;
        int hasDuplicate = 0;
        int digits[10] = {0};

        while (num > 0) {
            int digit = num % 10;
            if (digits[digit]) {
                hasDuplicate = 1;
                break;
            }
            digits[digit] = 1;
            num /= 10;
        }

        if (!hasDuplicate) {
            result[index++] = i;
        }
    }

    *returnSize = index;
    return result;
}