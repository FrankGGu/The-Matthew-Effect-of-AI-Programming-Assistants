#include <stdlib.h>

int* numberOfPairs(int* nums, int numsSize, int* returnSize) {
    int counts[101] = {0};

    for (int i = 0; i < numsSize; i++) {
        counts[nums[i]]++;
    }

    int pairs = 0;
    int remaining = 0;

    for (int i = 0; i <= 100; i++) {
        pairs += counts[i] / 2;
        remaining += counts[i] % 2;
    }

    int* result = (int*) malloc(sizeof(int) * 2);

    result[0] = pairs;
    result[1] = remaining;

    *returnSize = 2;

    return result;
}