#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int count[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        count[digits[i]]++;
    }

    int* result = (int*)malloc(sizeof(int) * 500);
    *returnSize = 0;

    for (int i = 100; i <= 998; i += 2) {
        int temp = i;
        int c[10] = {0};
        c[temp % 10]++;
        temp /= 10;
        c[temp % 10]++;
        temp /= 10;
        c[temp % 10]++;

        int valid = 1;
        for (int j = 0; j < 10; j++) {
            if (c[j] > count[j]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}