#include <stdlib.h>

int* majorityElement(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int candidate1 = nums[0];
    int candidate2 = nums[0];
    int count1 = 0;
    int count2 = 0;

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

    int final_count1 = 0;
    int final_count2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == candidate1) {
            final_count1++;
        } else if (nums[i] == candidate2) {
            final_count2++;
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 0;

    if (final_count1 > numsSize / 3) {
        result[(*returnSize)++] = candidate1;
    }
    if (candidate1 != candidate2 && final_count2 > numsSize / 3) {
        result[(*returnSize)++] = candidate2;
    }

    return result;
}