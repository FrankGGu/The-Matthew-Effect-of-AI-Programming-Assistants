#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMedian(int* nums, int numsSize) {
    int* uniqueNums = (int*)malloc(sizeof(int) * numsSize);
    int uniqueSize = 0;
    int* count = (int*)malloc(sizeof(int) * 20001);
    for (int i = 0; i < 20001; i++) {
        count[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        count[nums[i] + 10000]++;
    }

    for (int i = 0; i < 20001; i++) {
        if (count[i] > 0) {
            uniqueNums[uniqueSize++] = i - 10000;
        }
    }

    free(count);

    if (uniqueSize % 2 == 0) {
        return (uniqueNums[uniqueSize / 2 - 1] + uniqueNums[uniqueSize / 2]) / 2;
    } else {
        return uniqueNums[uniqueSize / 2];
    }

    free(uniqueNums);
    return 0;
}