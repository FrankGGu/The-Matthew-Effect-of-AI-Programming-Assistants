#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minArrayLength(int* nums, int numsSize) {
    int count[100001] = {0};
    int maxCount = 0;

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
        if (count[nums[i]] > maxCount) {
            maxCount = count[nums[i]];
        }
    }

    if (maxCount <= numsSize / 2) {
        return numsSize % 2;
    } else {
        return 2 * maxCount - numsSize;
    }
}