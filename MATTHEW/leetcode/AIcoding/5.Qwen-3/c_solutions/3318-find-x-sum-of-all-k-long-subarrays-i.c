#include <stdio.h>
#include <stdlib.h>

int* kSum(int* nums, int numsSize, int k, int* returnSize) {
    int n = numsSize;
    int* result = (int*)malloc(n - k + 1 * sizeof(int));
    *returnSize = n - k + 1;

    for (int i = 0; i <= n - k; i++) {
        int sum = 0;
        for (int j = 0; j < k; j++) {
            sum += nums[i + j];
        }
        result[i] = sum;
    }

    return result;
}