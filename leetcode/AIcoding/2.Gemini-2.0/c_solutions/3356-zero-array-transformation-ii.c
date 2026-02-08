#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool solve(int* nums, int numsSize) {
    int pos = 0, neg = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            pos++;
        } else if (nums[i] < 0) {
            neg++;
        }
    }
    if (pos == 0 && neg == 0) return true;

    if (pos == 0 || neg == 0) {
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] != 0) return false;
        }
        return true;
    }

    int l = 0, r = numsSize - 1;
    while (l < numsSize && nums[l] == 0) l++;
    while (r >= 0 && nums[r] == 0) r--;

    if (l > r) return true;

    if (nums[l] > 0 && nums[r] < 0) return false;
    if (nums[l] < 0 && nums[r] > 0) return true;

    if (nums[l] > 0) {
        for (int i = 0; i < numsSize - 1; i++) {
            if (nums[i] > nums[i + 1]) return false;
        }
    } else {
        for (int i = 0; i < numsSize - 1; i++) {
            if (nums[i] < nums[i + 1]) return false;
        }
    }

    return true;
}

bool checkArray(int* nums, int numsSize) {
    return solve(nums, numsSize);
}