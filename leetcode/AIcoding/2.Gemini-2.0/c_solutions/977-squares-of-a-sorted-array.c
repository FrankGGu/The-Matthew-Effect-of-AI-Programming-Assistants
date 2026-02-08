#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* sortedSquares(int* nums, int numsSize, int* returnSize){
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    int left = 0;
    int right = numsSize - 1;
    int index = numsSize - 1;

    while (left <= right) {
        int left_sq = nums[left] * nums[left];
        int right_sq = nums[right] * nums[right];

        if (left_sq > right_sq) {
            result[index] = left_sq;
            left++;
        } else {
            result[index] = right_sq;
            right--;
        }
        index--;
    }

    return result;
}