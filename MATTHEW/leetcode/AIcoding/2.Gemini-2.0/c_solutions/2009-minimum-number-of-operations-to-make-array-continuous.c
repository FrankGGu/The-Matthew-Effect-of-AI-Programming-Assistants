#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int* nums, int numsSize){
    qsort(nums, numsSize, sizeof(int), cmp);

    int uniqueSize = 0;
    int* uniqueNums = (int*)malloc(sizeof(int) * numsSize);
    if (uniqueNums == NULL) {
        return -1;
    }

    if (numsSize > 0) {
        uniqueNums[uniqueSize++] = nums[0];
    }

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i - 1]) {
            uniqueNums[uniqueSize++] = nums[i];
        }
    }

    int maxLen = 0;
    for (int i = 0; i < uniqueSize; i++) {
        int end = uniqueNums[i] + numsSize - 1;
        int left = i;
        int right = uniqueSize - 1;
        int pos = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (uniqueNums[mid] <= end) {
                pos = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (pos != -1) {
            int len = pos - i + 1;
            if (len > maxLen) {
                maxLen = len;
            }
        }
    }

    free(uniqueNums);
    return numsSize - maxLen;
}