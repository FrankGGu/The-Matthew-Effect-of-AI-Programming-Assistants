#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* separateDigits(int* nums, int numsSize, int* returnSize) {
    int totalDigits = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num == 0) {
            totalDigits++;
        } else {
            int count = 0;
            while (num > 0) {
                num /= 10;
                count++;
            }
            totalDigits += count;
        }
    }

    int* result = (int*)malloc(sizeof(int) * totalDigits);
    *returnSize = totalDigits;

    int index = 0;
    for (int i = 0; i < numsSize; i++) {
        char str[11];
        sprintf(str, "%d", nums[i]);
        int len = strlen(str);
        for (int j = 0; j < len; j++) {
            result[index++] = str[j] - '0';
        }
    }

    return result;
}