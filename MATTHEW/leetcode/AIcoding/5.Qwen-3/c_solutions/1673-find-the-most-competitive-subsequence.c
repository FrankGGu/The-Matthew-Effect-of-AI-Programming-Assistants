#include <stdio.h>
#include <stdlib.h>

int* mostCompetitive(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    int top = -1;
    for (int i = 0; i < numsSize; i++) {
        while (top >= 0 && nums[i] < result[top] && (numsSize - i + top) > k) {
            top--;
        }
        if (top < k - 1) {
            result[++top] = nums[i];
        }
    }
    *returnSize = k;
    return result;
}