#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findMinDifference(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int minDiff = INT_MAX;
    for (int i = 1; i < numsSize; i++) {
        minDiff = (nums[i] - nums[i-1] < minDiff) ? nums[i] - nums[i-1] : minDiff;
    }
    return minDiff;
}

int main() {
    return 0;
}