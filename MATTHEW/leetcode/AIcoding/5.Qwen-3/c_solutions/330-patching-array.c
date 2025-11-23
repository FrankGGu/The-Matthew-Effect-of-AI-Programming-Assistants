#include <stdio.h>
#include <stdlib.h>

int* patchingArray(int* nums, int numsSize, int n, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * numsSize + 10);
    int i = 0, j = 0;
    long long miss = 1;
    while (miss <= n) {
        if (i < numsSize && nums[i] <= miss) {
            miss += nums[i];
            i++;
        } else {
            miss += miss;
            result[j++] = miss;
        }
    }
    *returnSize = j;
    return result;
}