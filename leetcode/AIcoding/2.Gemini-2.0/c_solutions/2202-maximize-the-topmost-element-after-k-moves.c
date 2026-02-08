#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumTop(int* nums, int numsSize, int k){
    if (numsSize == 1) {
        if (k % 2 == 1) {
            return -1;
        } else {
            return nums[0];
        }
    }

    if (k > numsSize) {
        return *max_element(nums, nums + numsSize);
    }

    if (k == numsSize) {
        return *max_element(nums, nums + numsSize - 1);
    }

    int maxVal = -1;
    for (int i = 0; i < k - 1; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    if (nums[k] > maxVal) {
        maxVal = nums[k];
    }

    return maxVal;
}

int* max_element(int* first, int* last) {
    if (first == last) {
        return last;
    }

    int* max = first;
    first++;

    while (first != last) {
        if (*first > *max) {
            max = first;
        }
        first++;
    }

    return max;
}