#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int largestSumAfterKNegations(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize && k > 0; i++) {
        if (nums[i] < 0) {
            nums[i] = -nums[i];
            k--;
        } else {
            break;
        }
    }

    if (k % 2 == 1) {
        int minIndex = 0;
        for (int i = 1; i < numsSize; i++) {
            if (nums[i] < nums[minIndex]) {
                minIndex = i;
            }
        }
        nums[minIndex] = -nums[minIndex];
    }

    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    return sum;
}