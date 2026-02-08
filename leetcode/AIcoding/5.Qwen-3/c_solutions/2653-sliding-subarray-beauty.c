#include <stdio.h>
#include <stdlib.h>

int* slidingSubarrayBeauty(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (numsSize - k + 1));
    *returnSize = numsSize - k + 1;

    for (int i = 0; i <= numsSize - k; i++) {
        int count[101] = {0};
        for (int j = i; j < i + k; j++) {
            if (nums[j] > 0) {
                count[nums[j]]++;
            }
        }

        int beauty = 0;
        for (int m = 1; m <= 100 && beauty == 0; m++) {
            if (count[m] > 0) {
                beauty = m;
            }
        }
        result[i] = beauty;
    }

    return result;
}