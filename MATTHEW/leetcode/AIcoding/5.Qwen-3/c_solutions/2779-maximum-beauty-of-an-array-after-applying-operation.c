#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumBeauty(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int maxBeauty = 0;
    int left = 0;
    for (int right = 0; right < numsSize; right++) {
        while (nums[right] - nums[left] > 2 * k) {
            left++;
        }
        maxBeauty = (maxBeauty > right - left + 1) ? maxBeauty : right - left + 1;
    }
    return maxBeauty;
}