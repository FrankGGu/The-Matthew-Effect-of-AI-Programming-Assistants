#include <stdio.h>
#include <stdlib.h>

int* shuffle(int* nums, int n, int* returnSize) {
    int* result = (int*)malloc(2 * n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[2 * i] = nums[i];
        result[2 * i + 1] = nums[n + i];
    }
    *returnSize = 2 * n;
    return result;
}