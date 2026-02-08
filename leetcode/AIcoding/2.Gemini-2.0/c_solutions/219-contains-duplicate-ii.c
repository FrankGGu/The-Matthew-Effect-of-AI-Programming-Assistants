#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool containsNearbyDuplicate(int* nums, int numsSize, int k) {
    if (numsSize <= 1 || k <= 0) {
        return false;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize && j <= i + k; j++) {
            if (nums[i] == nums[j]) {
                return true;
            }
        }
    }

    return false;
}