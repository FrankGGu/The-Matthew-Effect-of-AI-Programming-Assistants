#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumDifference(int* nums, int numsSize, int k){
    if (k > numsSize || k <= 0) return 0;
    if (k == 1) return 0;

    qsort(nums, numsSize, sizeof(int), compare);

    int min_diff = nums[k - 1] - nums[0];
    for (int i = 1; i <= numsSize - k; i++) {
        int diff = nums[i + k - 1] - nums[i];
        if (diff < min_diff) {
            min_diff = diff;
        }
    }
    return min_diff;
}