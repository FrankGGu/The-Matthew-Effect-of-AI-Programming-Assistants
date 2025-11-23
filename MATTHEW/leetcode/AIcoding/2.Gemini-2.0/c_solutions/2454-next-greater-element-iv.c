#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* nextGreaterElements(int* nums, int numsSize, int* returnSize){
    int *result = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] > nums[i]) {
                for (int k = j + 1; k < numsSize; k++) {
                    if (nums[k] > nums[j]) {
                        result[i] = nums[k];
                        break;
                    }
                }
                break;
            }
        }
    }

    return result;
}