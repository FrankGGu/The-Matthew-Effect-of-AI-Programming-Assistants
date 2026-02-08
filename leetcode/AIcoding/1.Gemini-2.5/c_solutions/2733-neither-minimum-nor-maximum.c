#include <limits.h>

int findNonMinMax(int* nums, int numsSize) {
    if (numsSize < 3) {
        return -1;
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

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != minVal && nums[i] != maxVal) {
            return nums[i];
        }
    }

    return -1;
}