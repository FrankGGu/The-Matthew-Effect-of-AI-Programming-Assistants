#include <stdio.h>
#include <stdlib.h>

int* findLosers(int* nums, int numsSize, int* returnSize) {
    int* count = (int*)calloc(numsSize, sizeof(int));
    int* losers = NULL;
    int loserCount = 0;

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 0; i < numsSize; i++) {
        if (count[i] == 0) {
            loserCount++;
        }
    }

    losers = (int*)malloc(loserCount * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count[i] == 0) {
            losers[index++] = i;
        }
    }

    free(count);
    *returnSize = loserCount;
    return losers;
}