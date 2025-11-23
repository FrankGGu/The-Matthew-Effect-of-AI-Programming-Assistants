#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximizeSumAfterKNegations(int* nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(int), compare);

    int i = 0;
    while (k > 0 && i < numsSize && nums[i] < 0) {
        nums[i] = -nums[i];
        k--;
        i++;
    }

    if (k > 0 && k % 2 != 0) {
        qsort(nums, numsSize, sizeof(int), compare);
        nums[0] = -nums[0];
    }

    int sum = 0;
    for (int j = 0; j < numsSize; j++) {
        sum += nums[j];
    }

    return sum;
}