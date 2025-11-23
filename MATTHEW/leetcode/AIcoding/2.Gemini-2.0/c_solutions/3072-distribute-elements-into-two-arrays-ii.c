#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* distributeElements(int* nums, int numsSize, int* resultSize){
    int* arr1 = (int*)malloc(sizeof(int) * numsSize);
    int* arr2 = (int*)malloc(sizeof(int) * numsSize);
    int arr1Size = 0;
    int arr2Size = 0;

    for (int i = 0; i < numsSize; i++) {
        if (arr1Size == 0 || nums[i] >= arr1[arr1Size - 1]) {
            arr1[arr1Size++] = nums[i];
        } else if (arr2Size == 0 || nums[i] >= arr2[arr2Size - 1]) {
            arr2[arr2Size++] = nums[i];
        } else {
            if (arr1[arr1Size - 1] <= arr2[arr2Size - 1]) {
                arr1[arr1Size++] = nums[i];
            } else {
                arr2[arr2Size++] = nums[i];
            }
        }
    }

    int* result = (int*)malloc(sizeof(int) * numsSize);
    int resultIndex = 0;

    for (int i = 0; i < arr1Size; i++) {
        result[resultIndex++] = arr1[i];
    }
    for (int i = 0; i < arr2Size; i++) {
        result[resultIndex++] = arr2[i];
    }

    free(arr1);
    free(arr2);

    *resultSize = numsSize;
    return result;
}