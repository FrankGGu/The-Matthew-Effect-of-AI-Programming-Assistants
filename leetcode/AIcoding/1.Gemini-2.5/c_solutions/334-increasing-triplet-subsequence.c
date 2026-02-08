#include <stdbool.h>
#include <limits.h>

bool increasingTriplet(int* nums, int numsSize) {
    if (numsSize < 3) {
        return false;
    }

    int min1 = INT_MAX;
    int min2 = INT_MAX;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num <= min1) {
            min1 = num;
        } else if (num <= min2) {
            min2 = num;
        } else {
            return true;
        }
    }

    return false;
}