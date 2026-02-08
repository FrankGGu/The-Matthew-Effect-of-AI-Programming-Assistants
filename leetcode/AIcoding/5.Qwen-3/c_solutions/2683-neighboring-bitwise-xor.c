#include <stdio.h>
#include <stdlib.h>

int* resultArray(int* nums, int numsSize, int* returnSize) {
    int* arr1 = (int*)malloc(sizeof(int) * numsSize);
    int* arr2 = (int*)malloc(sizeof(int) * numsSize);
    int count1 = 0, count2 = 0;

    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    arr1[count1++] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if ((arr1[count1 - 1] ^ nums[i]) == 1) {
            arr2[count2++] = nums[i];
        } else {
            arr1[count1++] = nums[i];
        }
    }

    int* result = (int*)malloc(sizeof(int) * (count1 + count2));
    for (int i = 0; i < count1; i++) {
        result[i] = arr1[i];
    }
    for (int i = 0; i < count2; i++) {
        result[count1 + i] = arr2[i];
    }

    *returnSize = count1 + count2;
    free(arr1);
    free(arr2);
    return result;
}