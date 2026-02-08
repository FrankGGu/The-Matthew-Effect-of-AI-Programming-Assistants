#include <stdio.h>
#include <stdlib.h>

int* distributeElementsToTwoArrays(int* nums, int numsSize, int* returnSize) {
    int* arr1 = (int*)malloc(numsSize * sizeof(int));
    int* arr2 = (int*)malloc(numsSize * sizeof(int));
    int count1 = 0, count2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count1 == 0 || nums[i] > arr1[count1 - 1]) {
            arr1[count1++] = nums[i];
        } else {
            arr2[count2++] = nums[i];
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = count1;
    result[1] = count2;
    *returnSize = 2;
    return result;
}