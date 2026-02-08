#include <stdlib.h> // For abs

int max(int a, int b) {
    return a > b ? a : b;
}

int maxCircularAdjacentDifference(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    int max_diff = 0;

    for (int i = 0; i < numsSize - 1; i++) {
        max_diff = max(max_diff, abs(nums[i] - nums[i+1]));
    }

    max_diff = max(max_diff, abs(nums[numsSize - 1] - nums[0]));

    return max_diff;
}