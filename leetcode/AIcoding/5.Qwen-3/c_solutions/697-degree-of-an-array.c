#include <stdio.h>
#include <stdlib.h>

int findShortestSubArray(int* nums, int numsSize) {
    int maxNum = 0;
    int minIndex = 0;
    int maxCount = 0;
    int* count = (int*)calloc(101, sizeof(int));
    int* firstIndex = (int*)calloc(101, sizeof(int));
    int* lastIndex = (int*)calloc(101, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (count[num] == 0) {
            firstIndex[num] = i;
        }
        count[num]++;
        lastIndex[num] = i;
        if (count[num] > maxCount || (count[num] == maxCount && num < maxNum)) {
            maxCount = count[num];
            maxNum = num;
        }
    }

    int result = numsSize;
    for (int i = 0; i <= 100; i++) {
        if (count[i] == maxCount) {
            result = (lastIndex[i] - firstIndex[i] + 1) < result ? (lastIndex[i] - firstIndex[i] + 1) : result;
        }
    }

    free(count);
    free(firstIndex);
    free(lastIndex);
    return result;
}