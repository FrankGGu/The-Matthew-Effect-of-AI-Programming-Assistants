#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* sequentialDigits(int low, int high, int* returnSize){
    int* result = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;

    for (int startDigit = 1; startDigit <= 9; startDigit++) {
        int num = startDigit;
        int nextDigit = startDigit + 1;

        while (num <= high && nextDigit <= 10) {
            if (num >= low && num <= high) {
                result[(*returnSize)++] = num;
            }

            if (nextDigit <= 9) {
                num = num * 10 + nextDigit;
                nextDigit++;
            } else {
                break;
            }
        }
    }

    for (int i = 0; i < *returnSize - 1; i++) {
        for (int j = i + 1; j < *returnSize; j++) {
            if (result[i] > result[j]) {
                int temp = result[i];
                result[i] = result[j];
                result[j] = temp;
            }
        }
    }

    return result;
}