#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minLength(int* nums, int numsSize) {
    int count[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    int maxCount = 0;
    for (int i = 1; i <= 100; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
        }
    }
    return numsSize - 2 * maxCount < 0 ? 1 : numsSize - 2 * maxCount;
}