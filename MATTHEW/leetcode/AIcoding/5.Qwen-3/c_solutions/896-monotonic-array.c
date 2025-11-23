#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool isMonotonic(int* nums, int numsSize) {
    bool increasing = true;
    bool decreasing = true;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i - 1]) {
            decreasing = false;
        } else if (nums[i] < nums[i - 1]) {
            increasing = false;
        }

        if (!increasing && !decreasing) {
            return false;
        }
    }

    return true;
}