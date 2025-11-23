#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int sumOfBeauty(int* nums, int numsSize) {
    int* leftMin = (int*)malloc(numsSize * sizeof(int));
    int* rightMax = (int*)malloc(numsSize * sizeof(int));

    leftMin[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        leftMin[i] = min(leftMin[i - 1], nums[i]);
    }

    rightMax[numsSize - 1] = nums[numsSize - 1];
    for (int i = numsSize - 2; i >= 0; i--) {
        rightMax[i] = max(rightMax[i + 1], nums[i]);
    }

    int sum = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        if (nums[i] > leftMin[i] && nums[i] < rightMax[i]) {
            sum += 1;
        } else if (nums[i] > leftMin[i] && nums[i] == rightMax[i]) {
            sum += 1;
        } else if (nums[i] == leftMin[i] && nums[i] < rightMax[i]) {
            sum += 1;
        }
    }

    free(leftMin);
    free(rightMax);
    return sum;
}