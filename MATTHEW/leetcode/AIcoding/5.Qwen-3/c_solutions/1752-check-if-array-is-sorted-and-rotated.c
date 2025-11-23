#include <stdio.h>
#include <stdlib.h>

bool isSorted(int* nums, int numsSize) {
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[i - 1]) {
            return false;
        }
    }
    return true;
}

bool checkIfSortedAndRotated(int* nums, int numsSize) {
    if (numsSize == 0) return true;

    int count = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[i - 1]) {
            count++;
            if (count > 1) {
                return false;
            }
        }
    }

    if (count == 0) {
        return true;
    } else {
        return nums[0] >= nums[numsSize - 1];
    }
}