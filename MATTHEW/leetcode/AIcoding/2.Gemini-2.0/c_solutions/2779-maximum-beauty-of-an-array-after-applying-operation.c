#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumBeauty(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), (int (*)(const void *, const void *))cmp);
    int left = 0, right = 0, count = 0, maxCount = 0;
    while (right < numsSize) {
        if (nums[right] - nums[left] <= 2 * k) {
            count++;
            right++;
        } else {
            count--;
            left++;
        }
        if (count > maxCount) {
            maxCount = count;
        }
    }
    return maxCount;
}

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}