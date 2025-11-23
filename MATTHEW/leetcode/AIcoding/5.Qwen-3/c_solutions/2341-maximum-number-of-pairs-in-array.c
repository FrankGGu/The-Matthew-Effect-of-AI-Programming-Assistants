#include <stdio.h>
#include <stdlib.h>

int* maximumNumberOfPairs(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = 0;
    int* count = (int*)calloc(101, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 0; i <= 100; i++) {
        if (count[i] >= 2) {
            int pairs = count[i] / 2;
            result[0] += pairs;
            count[i] %= 2;
        }
    }

    for (int i = 0; i <= 100; i++) {
        if (count[i] == 1) {
            result[1]++;
        }
    }

    *returnSize = 2;
    free(count);
    return result;
}