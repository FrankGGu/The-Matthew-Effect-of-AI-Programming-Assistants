#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* numberOfPairs(int* nums, int numsSize, int* returnSize) {
    int count[101] = {0};
    int pairs = 0;
    int leftovers = 0;
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    for (int i = 0; i < 101; i++) {
        pairs += count[i] / 2;
        leftovers += count[i] % 2;
    }
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = pairs;
    result[1] = leftovers;
    *returnSize = 2;
    return result;
}