#include <stdlib.h>

int* separateDigits(int* nums, int numsSize, int* returnSize) {
    int totalDigits = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        while (num > 0) {
            totalDigits++;
            num /= 10;
        }
    }

    int* result = (int*)malloc(totalDigits * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int digits[10];
        int count = 0;

        while (num > 0) {
            digits[count++] = num % 10;
            num /= 10;
        }

        for (int j = count - 1; j >= 0; j--) {
            result[index++] = digits[j];
        }
    }

    *returnSize = totalDigits;
    return result;
}