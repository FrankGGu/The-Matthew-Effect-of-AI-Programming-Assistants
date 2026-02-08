#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int* shortestSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;
    *returnSize = 2;

    int n = numsSize;
    int minLen = INT_MAX;

    for (int i = 0; i < n; i++) {
        int orVal = 0;
        for (int j = i; j < n; j++) {
            orVal |= nums[j];
            if (orVal >= k) {
                if (j - i + 1 < minLen) {
                    minLen = j - i + 1;
                    result[0] = i;
                    result[1] = j;
                }
                break;
            }
        }
    }

    if (minLen == INT_MAX) {
        free(result);
        result = (int*)malloc(2 * sizeof(int));
        result[0] = -1;
        result[1] = -1;
        *returnSize = 2;
    }

    return result;
}