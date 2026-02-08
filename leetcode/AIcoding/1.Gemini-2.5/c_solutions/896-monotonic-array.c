#include <stdbool.h>

bool isMonotonic(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return true;
    }

    bool isIncreasing = true;
    bool isDecreasing = true;

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] > nums[i+1]) {
            isIncreasing = false;
        }
        if (nums[i] < nums[i+1]) {
            isDecreasing = false;
        }
    }

    return isIncreasing || isDecreasing;
}