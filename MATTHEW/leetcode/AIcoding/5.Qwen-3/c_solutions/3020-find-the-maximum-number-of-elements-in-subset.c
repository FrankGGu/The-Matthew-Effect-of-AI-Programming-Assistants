#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumElements(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int count = 0;
    int sum = 0;
    for (int i = numsSize - 1; i >= 0; i--) {
        if (sum + nums[i] <= 1000) {
            sum += nums[i];
            count++;
        } else {
            break;
        }
    }
    return count;
}