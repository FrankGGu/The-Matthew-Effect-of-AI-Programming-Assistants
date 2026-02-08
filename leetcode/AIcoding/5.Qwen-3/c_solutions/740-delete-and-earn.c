#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int deleteAndEarn(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), compare);

    int maxNum = nums[numsSize - 1];
    int* count = (int*)calloc(maxNum + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int prev = 0, curr = 0;
    for (int i = 1; i <= maxNum; i++) {
        int temp = curr;
        curr = (prev + i * count[i]) > curr ? (prev + i * count[i]) : curr;
        prev = temp;
    }

    free(count);
    return curr;
}