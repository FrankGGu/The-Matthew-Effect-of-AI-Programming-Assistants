#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int largestSumAfterKNegations(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int i;
    for (i = 0; i < numsSize && k > 0; i++) {
        if (nums[i] < 0) {
            nums[i] *= -1;
            k--;
        } else {
            break;
        }
    }
    qsort(nums, numsSize, sizeof(int), compare);
    int sum = 0;
    for (i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (k % 2 == 1) {
        sum -= 2 * nums[0];
    }
    return sum;
}