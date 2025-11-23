#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getSubarrayBeauty(int* nums, int numsSize, int k, int x, int* returnSize){
    int* result = (int*)malloc(sizeof(int) * (numsSize - k + 1));
    *returnSize = numsSize - k + 1;

    for (int i = 0; i <= numsSize - k; i++) {
        int count = 0;
        for (int j = i; j < i + k; j++) {
            if (nums[j] < 0) {
                count++;
            }
        }

        if (count < x) {
            result[i] = 0;
            continue;
        }

        int negative_count = 0;
        for (int j = i; j < i + k; j++) {
            if (nums[j] < 0) {
                negative_count++;
                if (negative_count == x) {
                    result[i] = nums[j];
                    break;
                }
            }
        }
    }

    return result;
}