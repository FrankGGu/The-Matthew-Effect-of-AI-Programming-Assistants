#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 450); // Max possible even 3-digit numbers (100-998) / 2 + 1 = 450
    *returnSize = 0;

    int counts[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        counts[digits[i]]++;
    }

    for (int num = 100; num <= 998; num += 2) {
        int d1 = num / 100;
        int d2 = (num / 10) % 10;
        int d3 = num % 10;

        counts[d1]--;
        counts[d2]--;
        counts[d3]--;

        if (counts[d1] >= 0 && counts[d2] >= 0 && counts[d3] >= 0) {
            result[*returnSize] = num;
            (*returnSize)++;
        }

        counts[d1]++;
        counts[d2]++;
        counts[d3]++;
    }

    return result;
}