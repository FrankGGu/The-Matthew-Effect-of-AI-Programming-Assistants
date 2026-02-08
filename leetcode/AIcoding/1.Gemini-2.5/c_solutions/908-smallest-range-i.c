#include <stdlib.h> // Required for abs, although not strictly needed for this problem as max-min >= 0
#include <limits.h> // Required for INT_MAX, INT_MIN

int smallestRangeI(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }

    int minVal = INT_MAX;
    int maxVal = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    int diff = maxVal - minVal;

    if (diff <= 2 * k) {
        return 0;
    } else {
        return diff - 2 * k;
    }
}