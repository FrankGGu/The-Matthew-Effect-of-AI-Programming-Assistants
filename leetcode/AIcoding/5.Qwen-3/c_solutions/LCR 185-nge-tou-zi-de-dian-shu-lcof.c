#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double* twoSum(int numsSize, int* nums, int target, int* returnSize) {
    *returnSize = 2;
    double* result = (double*)malloc(sizeof(double) * 2);
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] + nums[j] == target) {
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }
    return result;
}