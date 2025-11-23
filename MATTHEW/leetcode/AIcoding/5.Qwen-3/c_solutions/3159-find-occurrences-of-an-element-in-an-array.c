#include <stdio.h>
#include <stdlib.h>

int* occurrencesOfElement(int* nums, int numsSize, int x, int* returnSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == x) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == x) {
            result[index++] = i;
        }
    }

    *returnSize = count;
    return result;
}