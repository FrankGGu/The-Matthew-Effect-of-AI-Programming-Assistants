#include <stdlib.h>

int* distributeRepeatingIntegers(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int total = 0;

    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int index = 0;
    while (total > 0) {
        for (int i = 0; i < numsSize && total > 0; i++) {
            if (nums[i] > 0) {
                result[index++] = i + 1;
                nums[i]--;
                total--;
            }
        }
    }

    return result;
}