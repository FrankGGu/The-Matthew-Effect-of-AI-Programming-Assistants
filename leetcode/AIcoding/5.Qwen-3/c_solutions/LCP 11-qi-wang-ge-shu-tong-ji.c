#include <stdio.h>
#include <stdlib.h>

double* expectedNumbers(int* nums, int numsSize, int* returnSize) {
    int count[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    double* result = (double*)malloc(sizeof(double) * 1001);
    *returnSize = 0;

    for (int i = 1; i <= 1000; i++) {
        if (count[i] > 0) {
            result[*returnSize] = (double)i / (double)count[i];
            (*returnSize)++;
        }
    }

    return result;
}