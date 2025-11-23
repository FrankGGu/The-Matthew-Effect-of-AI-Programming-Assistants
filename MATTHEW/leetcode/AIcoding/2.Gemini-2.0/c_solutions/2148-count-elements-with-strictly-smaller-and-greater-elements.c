#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countElements(int* nums, int numsSize) {
    if (numsSize <= 2) {
        return 0;
    }

    int minVal = nums[0];
    int maxVal = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > minVal && nums[i] < maxVal) {
            count++;
        }
    }

    return count;
}