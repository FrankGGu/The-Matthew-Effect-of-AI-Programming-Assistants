#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* resultArray(int* nums, int numsSize, int* returnSize) {
    int* arr1 = (int*)malloc(sizeof(int) * numsSize);
    int* arr2 = (int*)malloc(sizeof(int) * numsSize);
    int count1 = 0, count2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count1 == 0 || nums[i] < arr1[count1 - 1]) {
            arr1[count1++] = nums[i];
        } else if (count2 == 0 || nums[i] < arr2[count2 - 1]) {
            arr2[count2++] = nums[i];
        } else {
            if (count1 <= count2) {
                arr1[count1++] = nums[i];
            } else {
                arr2[count2++] = nums[i];
            }
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