#include <stdio.h>
#include <stdlib.h>

int* semiOrderedPermutation(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }

    int pos1 = -1, pos2 = -1;
    for (int i = 0; i < numsSize; i++) {
        if (result[i] == 1) {
            pos1 = i;
        } else if (result[i] == numsSize) {
            pos2 = i;
        }
    }

    if (pos1 < pos2) {
        for (int i = pos1; i > 0; i--) {
            int temp = result[i];
            result[i] = result[i - 1];
            result[i - 1] = temp;
        }
        for (int i = pos2; i < numsSize - 1; i++) {
            int temp = result[i];
            result[i] = result[i + 1];
            result[i + 1] = temp;
        }
    } else {
        for (int i = pos2; i < numsSize - 1; i++) {
            int temp = result[i];
            result[i] = result[i + 1];
            result[i + 1] = temp;
        }
        for (int i = pos1; i > 0; i--) {
            int temp = result[i];
            result[i] = result[i - 1];
            result[i - 1] = temp;
        }
    }

    *returnSize = numsSize;
    return result;
}