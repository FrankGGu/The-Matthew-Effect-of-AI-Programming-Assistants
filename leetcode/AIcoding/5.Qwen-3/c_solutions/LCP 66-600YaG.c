#include <stdio.h>
#include <stdlib.h>

int minNumber(int[] nums, int numsSize) {
    if (numsSize == 0) return 0;

    int* res = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        res[i] = 1;
    }

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i - 1]) {
            res[i] = res[i - 1] + 1;
        }
    }

    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] > nums[i + 1]) {
            res[i] = (res[i] > res[i + 1] + 1) ? res[i] : res[i + 1] + 1;
        }
    }

    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += res[i];
    }

    free(res);
    return sum;
}