#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int* shortestSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;
    int minLen = INT_MAX;

    for (int i = 0; i < numsSize; i++) {
        int orVal = 0;
        for (int j = i; j < numsSize; j++) {
            orVal |= nums[j];
            if (orVal >= k) {
                int len = j - i + 1;
                if (len < minLen) {
                    minLen = len;
                    result[0] = i;
                    result[1] = j;
                }
                break;
            }
        }
    }

    if (minLen != INT_MAX) {
        *returnSize = 2;
        return result;
    } else {
        *returnSize = 0;
        free(result);
        return NULL;
    }
}