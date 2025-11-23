#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubarrays(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < (1 << numsSize); i++) {
        int subarraySize = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                subarraySize++;
            }
        }

        if (subarraySize == numsSize) {
            continue;
        }

        int* newNums = (int*)malloc(sizeof(int) * (numsSize - subarraySize));
        int index = 0;
        for (int j = 0; j < numsSize; j++) {
            if (!((i >> j) & 1)) {
                newNums[index++] = nums[j];
            }
        }

        bool isIncreasing = true;
        for (int j = 1; j < numsSize - subarraySize; j++) {
            if (newNums[j] <= newNums[j - 1]) {
                isIncreasing = false;
                break;
            }
        }

        if (isIncreasing) {
            count++;
        }
        free(newNums);
    }
    return count;
}