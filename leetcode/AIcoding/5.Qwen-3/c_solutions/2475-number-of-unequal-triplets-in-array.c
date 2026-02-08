#include <stdio.h>
#include <stdlib.h>

int unequalTriplets(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if (nums[i] != nums[j] && nums[j] != nums[k] && nums[i] != nums[k]) {
                    count++;
                }
            }
        }
    }
    return count;
}