#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int* result = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;

    int count[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        count[digits[i]]++;
    }

    for (int i = 100; i < 1000; i += 2) {
        int temp = i;
        int tempCount[10] = {0};
        int valid = 1;

        while (temp > 0) {
            tempCount[temp % 10]++;
            temp /= 10;
        }

        for (int j = 0; j < 10; j++) {
            if (tempCount[j] > count[j]) {
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