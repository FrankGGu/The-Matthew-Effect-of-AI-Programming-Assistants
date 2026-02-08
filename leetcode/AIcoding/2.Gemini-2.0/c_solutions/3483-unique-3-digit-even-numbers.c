#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int count[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        count[digits[i]]++;
    }

    int* result = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    for (int i = 100; i <= 998; i += 2) {
        int temp = i;
        int digitCount[10] = {0};
        digitCount[temp % 10]++;
        temp /= 10;
        digitCount[temp % 10]++;
        temp /= 10;
        digitCount[temp % 10]++;

        int possible = 1;
        for (int j = 0; j < 10; j++) {
            if (digitCount[j] > count[j]) {
                possible = 0;
                break;
            }
        }

        if (possible) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}