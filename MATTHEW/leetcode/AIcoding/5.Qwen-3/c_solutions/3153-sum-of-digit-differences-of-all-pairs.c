#include <stdio.h>
#include <stdlib.h>

long long sumOfDigitDifferences(int* nums, int numsSize) {
    long long result = 0;
    int count[10][10] = {0};

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int digits[10] = {0};
        int pos = 0;
        while (num > 0) {
            int d = num % 10;
            digits[pos++] = d;
            num /= 10;
        }
        for (int j = 0; j < pos; j++) {
            for (int k = j + 1; k < pos; k++) {
                count[digits[j]][digits[k]]++;
            }
        }
    }

    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            if (i != j) {
                result += (long long)count[i][j] * count[j][i];
            }
        }
    }

    return result;
}