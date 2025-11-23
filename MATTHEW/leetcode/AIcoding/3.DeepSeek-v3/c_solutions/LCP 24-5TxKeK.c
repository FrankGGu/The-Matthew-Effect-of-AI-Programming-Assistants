#include <stdlib.h>
#include <string.h>

int* numsGame(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    long* prefix = (long*)malloc(numsSize * sizeof(long));
    int* result = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        nums[i] -= i;
    }

    long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        prefix[i] = sum;
    }

    for (int i = 0; i < numsSize; i++) {
        long median = nums[i / 2];
        long cost = (i + 1) * median - prefix[i];
        result[i] = cost % 1000000007;
    }

    free(prefix);
    return result;
}