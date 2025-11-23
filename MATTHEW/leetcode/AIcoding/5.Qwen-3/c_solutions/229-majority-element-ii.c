#include <stdio.h>
#include <stdlib.h>

int* majorityElement(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 0;

    int candidate1 = 0, candidate2 = 0;
    int count1 = 0, count2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == candidate1) {
            count1++;
        } else if (nums[i] == candidate2) {
            count2++;
        } else if (count1 == 0) {
            candidate1 = nums[i];
            count1 = 1;
        } else if (count2 == 0) {
            candidate2 = nums[i];
            count2 = 1;
        } else {
            count1--;
            count2--;
        }
    }

    count1 = 0;
    count2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == candidate1) count1++;
        else if (nums[i] == candidate2) count2++;
    }

    if (count1 > numsSize / 3) result[(*returnSize)++] = candidate1;
    if (count2 > numsSize / 3) result[(*returnSize)++] = candidate2;

    return result;
}